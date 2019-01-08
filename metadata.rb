name 'blackfire'
maintainer 'Blackfire.io'
maintainer_email 'support@blackfire.io'
license 'MIT'
description 'Installs and configures Blackfire.io stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.2.0'

recipe 'default', 'Installs blackfire-php & blackfire-agent.'
recipe 'php', 'Installs only blackfire-php'
recipe 'agent', 'Installs only blackfire-agent'
recipe 'repository', 'Setup Blackfire repository'

supports 'debian'
supports 'ubuntu'
supports 'redhat'
supports 'fedora'
supports 'centos'
supports 'amazon'

depends 'apt'
depends 'yum'
