#
# Cookbook Name:: blackfire
# Recipe:: agent
#
# Copyright 2014-2015, SensioLabs
# See LICENSE file
#

include_recipe "#{cookbook_name}::repository"

agent_version = node[cookbook_name]['agent']['version'] ? node[cookbook_name]['agent']['version'] : Blackfire::Versions.agent(node)

agent_version << '-1' if platform_family?('rhel', 'fedora', 'amazon')

package 'blackfire-agent' do
  version agent_version
end

template '/etc/blackfire/agent' do
  source 'agent.erb'
  variables(
    'ca_cert' => node[cookbook_name]['agent']['ca_cert'],
    'collector' => node[cookbook_name]['agent']['collector'],
    'server_id' => node[cookbook_name]['agent']['server_id'],
    'server_token' => node[cookbook_name]['agent']['server_token'],
    'log_file' => node[cookbook_name]['agent']['log_file'],
    'log_level' => node[cookbook_name]['agent']['log_level'],
    'socket' => node[cookbook_name]['agent']['socket'],
    'spec' => node[cookbook_name]['agent']['spec']
  )
end

service 'blackfire-agent' do
  not_if { node[cookbook_name]['agent']['server_id'].to_s.empty? }
  not_if { node[cookbook_name]['agent']['server_token'].to_s.empty? }
  supports status: true, start: true, stop: true, restart: true
  action [:enable]
  subscribes :restart, 'template[/etc/blackfire/agent]',  node[cookbook_name]['agent']['restart_mode']
end
