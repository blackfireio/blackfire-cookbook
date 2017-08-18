#
# Cookbook Name:: blackfire
# Recipe:: php
#
# Copyright 2014-2015, SensioLabs
# See LICENSE file
#

include_recipe "#{cookbook_name}::repository"

ruby_block 'blackfire-php-restart-webserver' do
  block do
    Chef::Log.warn "\033[31mBlackfire PHP extension has been updated.\033[0m"
    Chef::Log.warn "\033[31mPlease restart your WebServers or\033[0m"
    Chef::Log.warn "\033[31mconsider having your resources subscribing to\033[0m"
    Chef::Log.warn "\033[31mblackfire::php resources\033[0m"
  end
  action :nothing
end

probe_version = node[cookbook_name]['php']['version'] ? node[cookbook_name]['php']['version'] : Blackfire::Versions.probe(node)

probe_version << '-1' if platform_family?('rhel', 'fedora', 'amazon')

package 'blackfire-php' do
  version probe_version
  notifies :run, 'ruby_block[blackfire-php-restart-webserver]'
end

template node[cookbook_name]['php']['ini_path'] do
  source 'blackfire.ini.erb'
  variables(
    'agent_timeout' => node[cookbook_name]['php']['agent_timeout'],
    'log_file' => node[cookbook_name]['php']['log_file'],
    'log_level' => node[cookbook_name]['php']['log_level'],
    'socket' => node[cookbook_name]['agent']['socket'],
    'server_id' => node[cookbook_name]['php']['server_id'],
    'server_token' => node[cookbook_name]['php']['server_token']
  )
  notifies :run, 'ruby_block[blackfire-php-restart-webserver]', :immediately
end
