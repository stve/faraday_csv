require 'spec_helper'

describe Faraday::Response::CSV do
  let(:options) { Hash.new }
  let(:headers) { Hash.new }
  let(:app) do
    lambda { |env| Faraday::Response.new(env) }
  end
  let(:middleware) { Faraday::Response::CSV.new(app, options) }
  let(:body) { "integer,string\n12,foobar" }

  def process(response_body, content_type = nil, opts = {})
    env = {
      :body             => response_body,
      :request          => opts,
      :response_headers => Faraday::Utils::Headers.new(headers)
    }
    env[:response_headers]['content-type'] = content_type if content_type
    middleware.call(env)
  end

  it "parses valid csv syntax" do
    expect(process(body).body).to be_an Array
  end

  it 'raises Faraday::Error::ParsingError on invalid syntax' do
    allow(::CSV).to receive(:parse).and_raise(StandardError)

    expect{
      process('foo')
    }.to raise_error Faraday::Error::ParsingError
  end

  context 'with options' do
    let(:options) do
      { :parser_options => { :headers => true } }
    end

    it "parses valid csv syntax" do
      expect(process(body).body).to be_a CSV::Table
    end
  end

  context "integration tests" do
    let(:stubs) { Faraday::Adapter::Test::Stubs.new }
    let(:conn) do
      Faraday.new do |conn|
        conn.adapter :test, stubs
        conn.use Faraday::Response::CSV
      end
    end

    it "creates a hash from the body" do
      stubs.get("/csv") {[200, {'Content-Type' => 'text/csv'}, "integer,string\n12,foobar"]}
      expect(conn.get("/csv").body).to be_an Array
    end
  end
end
