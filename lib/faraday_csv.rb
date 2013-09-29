require 'faraday'

class Faraday::Response
  autoload :CSV, 'faraday/response/csv.rb'

  if Faraday.respond_to? :register_middleware
    Faraday.register_middleware :response,
      :csv => lambda { Faraday::Response::CSV }
  end
end
