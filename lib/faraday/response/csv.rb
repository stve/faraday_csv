require 'faraday'

module Faraday
  class Response::CSV < Response::Middleware
    dependency 'csv'

    def initialize(app = nil, options = {})
      super(app)
      @options = options
    end

    def parse(body)
      CSV.parse(body, @options)
    rescue Object => err
      raise Faraday::Error::ParsingError.new(err)
    end
  end
end
