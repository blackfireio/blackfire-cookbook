require './libraries/blackfire_versions_helper.rb'
require './libraries/blackfire_collector_mock.rb'
require 'rspec/core/rake_task'
require 'stove/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# Rspec and ChefSpec
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

# Integration tests. Kitchen.ci
namespace :integration do
  desc 'Run Kitchen Tests with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.vagrant.yml')
    Kitchen::Config.new(loader: @loader).instances.each do |instance|
      instance.test(:always)
    end
  end

  desc 'Run Kitchen Tests with Docker'
  task :docker do
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.docker.yml')
    Kitchen::Config.new(loader: @loader).instances.each do |instance|
      instance.test(:always)
    end
  end

  desc 'Run Kitchen Tests with cloud plugins'
  task :cloud do
    run_kitchen = true
    if ENV['TRAVIS'] == 'true' && ENV['TRAVIS_PULL_REQUEST'] != 'false'
      run_kitchen = false
    end

    if run_kitchen
      Kitchen.logger = Kitchen.default_file_logger
      @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.cloud.yml')
      config = Kitchen::Config.new(loader: @loader)
      config.instances.each do |instance|
        instance.test(:always)
      end
    end
  end
end

namespace :blackfire do
  desc 'Show current blackfire versions packages'
  task :versions do
    puts "Agent: #{Blackfire::Versions.agent}"
    puts "Probe: #{Blackfire::Versions.probe}"
  end

  namespace :collector do
    desc 'Run the mock collector for debug purpose'
    task :mock do
      Blackfire::CollectorMock.run('http://localhost:8780')
      sleep(10)
    end
  end
end

desc 'Deploy to supermarket'
Stove::RakeTask.new

desc 'Run all tests on Travis'
task travis: %w(style blackfire:versions spec)

# Default
task default: %w(style integration:vagrant)
