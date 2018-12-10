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

probe_version = Blackfire::Versions.probe(node)
probe_version << '-1' if platform_family?('rhel', 'fedora', 'amazon')

package 'blackfire-php' do
  version probe_version
  notifies :run, 'ruby_block[blackfire-php-restart-webserver]'
end

