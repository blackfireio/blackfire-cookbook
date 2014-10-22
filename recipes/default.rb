#
# Cookbook Name:: blackfire
# Recipe:: default
#
# Copyright 2014-2015, SensioLabs
# See LICENSE file
#

include_recipe "#{cookbook_name}::agent"
include_recipe "#{cookbook_name}::php"
