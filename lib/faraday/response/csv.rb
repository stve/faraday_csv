require 'faraday_middleware/response_middleware'

module Faraday
  class Response::CSV < FaradayMiddleware::ResponseMiddleware
    dependency do
      require 'csv' unless defined?(::CSV)
    end

    define_parser do |body, opts|
      ::CSV.parse(body, opts) unless body.strip.empty?
    end

    def initialize(app = nil, options = {})
      super(app, options)
      @parser_options = options[:parser_options] || {}
    end

    # Parse the response body.
    def parse(body)
      if self.class.parser
        begin
          self.class.parser.call(body, @parser_options)
        rescue StandardError, SyntaxError => err
          raise err if err.is_a? SyntaxError and err.class.name != 'Psych::SyntaxError'
          raise Faraday::Error::ParsingError, err
        end
      else
        body
      end
    end
  end
end
