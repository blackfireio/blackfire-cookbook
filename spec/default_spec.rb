require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start!

at_exit { ChefSpec::Coverage.report! }

describe 'blackfire::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.converge('blackfire::default')
  end

  it 'Install blackfire repository' do
    expect(chef_run).to add_apt_repository('blackfire')
  end

  it 'Install blackfire packages' do
    expect(chef_run).to install_package('blackfire-agent')
    expect(chef_run).to install_package('blackfire-php')
  end

  it 'Creates config file' do
    expect(chef_run).to create_template('/etc/blackfire/agent')
  end

  it 'Enables blackfire agent' do
    expect(chef_run).to enable_service('blackfire-agent')
    expect(chef_run.template('/etc/blackfire/agent')).to notify('service[blackfire-agent]').to(:restart)
  end
end

describe 'blackfire::default without repository installation' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['blackfire']['install_repository'] = false
    end.converge('blackfire::default')
  end

  it 'Install blackfire repository' do
    expect(chef_run).to_not add_apt_repository('blackfire')
  end

  it 'Install blackfire packages' do
    expect(chef_run).to install_package('blackfire-agent')
    expect(chef_run).to install_package('blackfire-php')
  end
end
