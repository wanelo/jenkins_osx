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
