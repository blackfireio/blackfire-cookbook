name 'blackfire'
maintainer 'SensioLabs'
maintainer_email 'support@sensiolabs.com'
license 'MIT'
description 'Installs and configures blackfire stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.1'

recipe 'default', 'Installs blackfire-php & blackfire-agent.'
recipe 'php', 'Installs only blackfire-php'
recipe 'agent', 'Installs only blackfire-agent'
recipe 'repository', 'Setup Blackfire repository'

supports 'debian'
supports 'ubuntu'
supports 'redhat'
supports 'fedora'
supports 'centos'

depends 'apt'
depends 'yum'
