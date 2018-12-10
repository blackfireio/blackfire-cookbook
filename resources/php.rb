# frozen_string_literal: true
#
# Cookbook:: blackfire
# Resource:: php
#
# Copyright 2014-2018, SensioLabs
# See LICENSE file
#

property :version,       String, name_property: true
property :cookbook,      String, default: 'blackfire'
property :ini_path,      String, default: ''
property :agent_timeout, String, default: '0.25'
property :log_file,      String
property :log_level,     String
property :socket,        String, default: 'unix:///var/run/blackfire/agent.sock'
property :server_id,     String
property :server_token,  String

action :create do
  local_ini_path = new_resource.ini_path

  if new_resource.ini_path.empty?
    version = new_resource.version
    v = version.to_i < 7 ? version.chr : version
    mods_path = version.to_i < 7 ? "/etc/php#{v}/mods-available" : "/etc/php/#{v}/mods-available"

    local_ini_path = if platform_family?('rhel', 'fedora', 'amazon')
                       '/etc/php.d/zz-blackfire.ini'
                     elsif platform?('debian') && node['platform_version'].to_f < 7.0
                       '/etc/php5/conf.d/blackfire.ini'
                     elsif platform?('ubuntu') && node['platform_version'].to_f <= 13.04
                       '/etc/php5/conf.d/blackfire.ini'
                     else
                       "#{mods_path}/blackfire.ini"
                     end
  end

  template local_ini_path do
    cookbook new_resource.cookbook
    source 'blackfire.ini.erb'
    variables(
      agent_timeout: new_resource.agent_timeout,
      log_file: new_resource.log_file,
      log_level: new_resource.log_level,
      socket: new_resource.socket,
      server_id: new_resource.server_id,
      server_token: new_resource.server_token
    )
  end

  execute 'phpenmod -v ALL blackfire' do
    only_if 'which phpenmod'
  end
end
