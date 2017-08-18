#
# Cookbook Name:: blackfire
# Recipe:: repository
#
# Copyright 2014-2015, SensioLabs
# See LICENSE file
#

case node['platform_family']
when 'rhel', 'fedora', 'amazon'
  yum_repository 'blackfire' do
    description 'blackfire'
    baseurl "#{node[cookbook_name]['repository']}/fedora/$releasever/$basearch"
    gpgkey 'https://packagecloud.io/gpg.key'
    gpgcheck false
    sslverify true
    sslcacert '/etc/pki/tls/certs/ca-bundle.crt'
    action [:create, :makecache]
    only_if { node['blackfire']['install_repository'] }
  end
else
  r = apt_repository 'blackfire' do
    uri "#{node[cookbook_name]['repository']}/#{node['platform']}"
    distribution 'any'
    key 'https://packagecloud.io/gpg.key'
    components ['main']
    action :nothing
    only_if { node['blackfire']['install_repository'] }
  end
  r.run_action(:add)

  unless r.updated?
    execute 'blackfire repository update' do
      command "apt-get update -o Dir::Etc::sourcelist='sources.list.d/#{r.name}.list' -o Dir::Etc::sourceparts='-' -o APT::Get::List-Cleanup='0'"
      ignore_failure true
      action :run
    end
  end
end
