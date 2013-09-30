# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday_csv/version'

Gem::Specification.new do |spec|
  spec.name        = 'faraday_csv'
  spec.version     = FaradayCSV::VERSION
  spec.homepage    = 'https://github.com/spagalloco/faraday_csv'

  spec.author      = "Steve Agalloco"
  spec.email       = 'steve.agalloco@gmail.com'
  spec.description = 'CSV Parsing Middleware for use with Faraday'
  spec.summary     = spec.description

  spec.add_dependency 'faraday'

  spec.licenses    = ['MIT']

  spec.files = %w(.yardopts LICENSE.md CHANGELOG.md README.md Rakefile faraday_csv.gemspec)
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("spec/**/*")
  spec.test_files = Dir.glob("spec/**/*")

  spec.require_paths = ['lib']
end
