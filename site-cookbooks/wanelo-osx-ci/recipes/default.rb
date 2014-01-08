#ruby_block 'block_until_operational' do
#  block do
#    Chef::Log.info "Waiting until Jenkins is listening on port #{node['jenkins']['server']['port']}"
#    until JenkinsHelper.service_listening?(node['jenkins']['server']['port'])
#      sleep 1
#      Chef::Log.debug('.')
#    end
#
#    Chef::Log.info 'Waiting until the Jenkins API is responding'
#    test_url = URI.parse("#{node['jenkins']['server']['url']}/api/json")
#    until JenkinsHelper.endpoint_responding?(test_url)
#      sleep 1
#      Chef::Log.debug('.')
#    end
#  end
#  action :nothing
#end
#
#execute 'symlink plist into LaunchAgents directory' do
#  command 'ln -sfv /usr/local/opt/jenkins/*.plist ~/Library/LaunchAgents'
#  user node['jenkins']['user']
#end
#
#execute 'launch jenkins now' do
#  command 'launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist'
#  user node['jenkins']['user']
#end

service 'postgresql' do
  supports :restart => true
  action [:restart]
end

#include_recipe 'wanelo-osx-ci::plugins'
#include_recipe 'wanelo-osx-ci::jobs'
#
