#
# Cookbook Name:: blackfire
# Recipe:: repository
#
# Copyright 2014-2015, SensioLabs
# See LICENSE file
#

case node['platform_family']
when 'rhel', 'fedora'
  yum_repository 'blackfire' do
    description 'blackfire'
    baseurl "#{node[cookbook_name]['repository']}/fedora/$releasever/$basearch"
    gpgkey 'https://packagecloud.io/gpg.key'
    gpgcheck false
    sslverify true
    sslcacert '/etc/pki/tls/certs/ca-bundle.crt'
    action :create
    only_if { node['blackfire']['install_repository'] }
  end
else
  apt_repository 'blackfire' do
    uri "#{node[cookbook_name]['repository']}/#{node['platform']}"
    distribution 'any'
    key 'https://packagecloud.io/gpg.key'
    components ['main']
    action :add
    only_if { node['blackfire']['install_repository'] }
  end
end
