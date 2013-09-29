# coding: utf-8
unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_group 'FaradayCSV', 'lib/faraday'
    add_group 'Specs', 'spec'
  end
end

require 'faraday_csv'
require 'rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
