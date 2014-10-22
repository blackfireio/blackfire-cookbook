#
# Cookbook Name:: blackfire
# Recipe:: mock
#
# Copyright 2014-2015, SensioLabs
# See LICENSE file
#

ruby_block 'run Blackfire Collector Mock' do
  block do
    Blackfire::CollectorMock.run(node[cookbook_name]['agent']['collector'])
  end
end
