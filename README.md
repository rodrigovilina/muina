# Muina

Typesafe base objects to make your code safer and cleaner.

## Installation

```ruby
gem 'muina'
```

## Usage

* Muina::Action: self extracting, step based, result returning features
* Muina::Params: self extracting typed params
* Muina::PrivateCreation: mixin to make `.new` and `.allocate` private
* Muina::Result: type safe result monad
* Muina::Service: service object with typesafe constants and attributes
* Muina::Value: typesafe immutable struct-like objects
* `muina` CLI: to copy bundled rbi file

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, 
which will create a git tag for the version, push git commits and the created tag, 
and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vaporyhumo/muina.
This project is intended to be a safe, welcoming space for collaboration.
