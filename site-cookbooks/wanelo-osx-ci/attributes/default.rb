default['jenkins']['user'] = 'wanelo'

# jenkins cookbook overrides
node.default['jenkins']['node']['home'] = '/Users/wanelo'
node.default['jenkins']['server']['host'] = 'localhost'
node.default['jenkins']['server']['url'] = 'http://localhost:8080'
node.default['jenkins']['server']['user'] = 'wanelo'
node.default['jenkins']['server']['plugins_dir_group'] = 'staff'
node.default['jenkins']['server']['group'] = 'staff'
node.default['jenkins']['server']['home'] = '/Users/wanelo/.jenkins'
