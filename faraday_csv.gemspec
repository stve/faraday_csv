# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday_csv/version'

Gem::Specification.new do |gem|
  gem.name        = 'faraday_csv'
  gem.version     = FaradayCSV::VERSION
  gem.homepage    = 'https://github.com/spagalloco/faraday_csv'

  gem.author      = "Steve Agalloco"
  gem.email       = 'steve.agalloco@gmail.com'
  gem.description = 'CSV Parsing Middleware for use with Faraday'
  gem.summary     = gem.description

  gem.add_dependency 'faraday'

  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.require_paths = ['lib']
end
