#
# Author:: Tugdual Saunier (<tugdual.saunier@sensiolabs.com>)
# Cookbook Name:: blackfire
# Attributes:: php
#
# Copyright 2014-2015, SensioLabs

default['blackfire']['php']['version'] = nil
default['blackfire']['php']['agent_timeout'] = '0.25'
default['blackfire']['php']['log_level'] = nil
default['blackfire']['php']['log_file'] = nil
default['blackfire']['php']['server_id'] = nil
default['blackfire']['php']['server_token'] = nil

if platform_family?('rhel', 'fedora', 'amazon')
  default['blackfire']['php']['ini_path'] = '/etc/php.d/zz-blackfire.ini'
elsif platform?('debian') && node['platform_version'].to_f < 7.0
  default['blackfire']['php']['ini_path'] = '/etc/php5/conf.d/blackfire.ini'
elsif platform?('ubuntu') && node['platform_version'].to_f <= 13.04
  default['blackfire']['php']['ini_path'] = '/etc/php5/conf.d/blackfire.ini'
else
  default['blackfire']['php']['ini_path'] = '/etc/php5/mods-available/blackfire.ini'
end
