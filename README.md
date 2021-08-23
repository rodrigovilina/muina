# Muina

[![Gem Version](https://badge.fury.io/rb/muina.svg)](https://badge.fury.io/rb/muina)

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
* `muina` CLI: to copy bundled rbi file


### Muina::Value

Value objects are one of the basic building blocks used in Domain Driven Design. They are immutable objects
whose equality is determined by the equality of its attributes and have no inherent identity.

`Muina::Value` leverages some of the modules used to build `T::Struct` so by declaring attributes with
`.const` you get a standard and typesafe initializer.

#### Examples

```ruby
class RGB < Muina::Value
  const :red,   Integer
  const :green, Integer
  const :blue,  Integer
end

# build instances with `.new` and key arguments
rgb = RGB.new(red: 10, green: 10, blue: 10)

# serialize with `#serialize`, 
# note that keys are symbols as opposed to `T::Struct#serialize` strings
rgb.serialize # => { red: 10, green: 10, blue: 10 }

# functionaly create new instances with modified attributes with `#with`
pixel.with(red: 20) # => <RGB red=20 green=10 blue=10>
```

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
