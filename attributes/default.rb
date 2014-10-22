#
# Author:: Tugdual Saunier (<tugdual.saunier@sensiolabs.com>)
# Cookbook Name:: blackfire
# Attributes:: default
#
# Copyright 2014-2015, SensioLabs

default['blackfire']['repository'] = 'http://packages.blackfire.io'
default['blackfire']['install_repository'] = true

default['blackfire']['agent']['version'] = nil
default['blackfire']['agent']['collector'] = 'https://blackfire.io'
default['blackfire']['agent']['server_id'] = nil
default['blackfire']['agent']['server_token'] = nil
default['blackfire']['agent']['log_level'] = 1
default['blackfire']['agent']['log_file'] = 'stderr'
default['blackfire']['agent']['socket'] = 'unix:///var/run/blackfire/agent.sock'
default['blackfire']['agent']['restart_mode'] = :delayed
