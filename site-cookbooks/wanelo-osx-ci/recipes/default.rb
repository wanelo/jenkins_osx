execute 'symlink plist into LaunchAgents directory' do
  command 'ln -sfv /usr/local/opt/jenkins/*.plist ~/Library/LaunchAgents'
  user node['jenkins']['user']
end

execute 'launch jenkins now' do
  command 'launchctl load ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist'
  user node['jenkins']['user']
end
