require 'faraday'

class Faraday::Response
  autoload :CSV, 'faraday/response/csv.rb'
end
