execute 'symlink plist into LaunchAgents directory' do
  command 'ln -sfv /usr/local/opt/jenkins/*.plist ~/Library/LaunchAgents'
  user node['jenkins']['user']
end

execute 'launch jenkins now' do
  command 'launchctl load ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist'
  user node['jenkins']['user']
end

job_name = 'vigorish'
job_filename = "#{job_name}_config.xml"
job_config = File.join(node[:jenkins][:node][:home], job_filename)

jenkins_job job_name do
  action :nothing
  config job_config
end

cookbook_file job_config do
  source    job_filename
  notifies  :update, resources(:jenkins_job => job_name), :immediately
  notifies  :build, resources(:jenkins_job => job_name), :immediately
end
