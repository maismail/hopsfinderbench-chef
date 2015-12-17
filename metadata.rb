name             'hopsfindbench'
maintainer       'Hops.io'
maintainer_email 'maism@hops.io'
license          'Apache 2.0'
description      'Installs/Configures hopsfindbench'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


depends 'ndb'
depends 'kagent'
depends 'hops'
depends 'ark'
depends 'elastic'
depends 'sudo'