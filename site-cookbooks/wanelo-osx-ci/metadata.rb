name             'wanelo-osx-ci'
maintainer       'Wanelo, Inc.'
maintainer_email 'dev@wanelo.com'
license          'MIT'
description      'Custom recipes for our CI Setup'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
supports         'mac_os_x'

depends 'jenkins'
