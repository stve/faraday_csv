require 'spec_helper'

describe Faraday::Response::CSV do
  let(:csv) { Faraday::Response::CSV.new }
  let(:body) { "integer,string\n12,foobar" }

  it "parses valid csv syntax" do
    parsed = csv.on_complete(:body => body)
    expect(parsed).to be_an Array
  end

  it 'raises Faraday::Error::ParsingError on invalid syntax' do
    expect{
      csv.on_complete(:body => ['foo'])
    }.to raise_error Faraday::Error::ParsingError
  end

  context 'with options' do
    let(:options) { { :headers => true } }
    let(:csv) { Faraday::Response::CSV.new(lambda { |env| env }, options) }

    it "parses valid csv syntax" do
      parsed = csv.on_complete(:body => body)
      expect(parsed).to be_a CSV::Table
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
