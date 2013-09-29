# Faraday CSV

CSV Parsing Middleware for use with [Faraday][]

[faraday]: https://github.com/lostisland/faraday

## Usage

```ruby
conn = Faraday::Connection.new(:url => "http://example.com") do |builder|
  builder.adapter Faraday.default_adapter
  builder.use Faraday::Response::CSV
end

resp = conn.get do |req|
  req.url "/path/to/a.csv"
end

contents = resp.body
contents['header_column']
# => column_value
```

You can also pass options, which are passed into `CSV::parse`:

```ruby
conn = Faraday::Connection.new(:url => "http://example.com") do |builder|
  builder.adapter Faraday.default_adapter
  builder.use Faraday::Response::CSV, :headers => true
end
```

## Contributing

Pull requests welcome: fork, make a topic branch, commit (squash when possible) *with tests* and I'll happily consider.

## Copyright

Copyright (c) 2013 Steve Agalloco. See [LICENSE](LICENSE.md) for detail
