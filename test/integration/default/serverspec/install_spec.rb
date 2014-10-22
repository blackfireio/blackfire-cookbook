require 'serverspec'

set :backend, :exec

describe file('/etc/blackfire/agent') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe service('blackfire-agent') do
  it { should be_enabled }
  it { should be_running }
end

describe user('blackfire') do
  it { should exist }
end
