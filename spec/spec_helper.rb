require 'bundler/setup'
require 'tilda/simple/api'
require 'webmock/rspec'
require 'pry-byebug'

Dir['./spec/support/**/*.rb'].sort.each(&method(:require))

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include StubbedRequests
end
