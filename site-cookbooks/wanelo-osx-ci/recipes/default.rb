ruby_block 'block_until_operational' do
  block do
    Chef::Log.info "Waiting until Jenkins is listening on port #{node['jenkins']['server']['port']}"
    until JenkinsHelper.service_listening?(node['jenkins']['server']['port'])
      sleep 1
      Chef::Log.debug('.')
    end

    Chef::Log.info 'Waiting until the Jenkins API is responding'
    test_url = URI.parse("#{node['jenkins']['server']['url']}/api/json")
    until JenkinsHelper.endpoint_responding?(test_url)
      sleep 1
      Chef::Log.debug('.')
    end
  end
  action :nothing
end

execute 'symlink plist into LaunchAgents directory' do
  command 'ln -sfv /usr/local/opt/jenkins/*.plist ~/Library/LaunchAgents'
  user node['jenkins']['user']
end

execute 'launch jenkins now' do
  command 'launchctl load ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist'
  user node['jenkins']['user']
end

service 'jenkins' do
  supports :status => true, :restart => true, :reload => true
  restart_command 'launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist && launchctl load ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist'
  action  [:start]
end

plugins_directory = File.join(node['jenkins']['server']['home'], 'plugins')
execute 'make plugins directory' do
  command "mkdir -p #{plugins_directory}"
  user node['jenkins']['user']
end


plugins = ['scm-api', 'git', 'github-api', 'github', 'git-client', 'notification', 'greenballs', 'campfire']
plugins.each do |plugin|
  jenkins_plugin plugin do
    action :install
  end
end

job_name = 'vigorish'
job_filename = "#{job_name}_config.xml"
job_config = File.join(node[:jenkins][:node][:home], '.jenkins', job_filename)

jenkins_job job_name do
  action :nothing
  config job_config
end

cookbook_file job_config do
  source    job_filename
  notifies  :update, resources(:jenkins_job => job_name), :immediately
  notifies  :build, resources(:jenkins_job => job_name), :immediately
end
