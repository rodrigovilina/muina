**Notice: This gem is being rewritten, expect news somewhat soonish**

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
* Muina::Service: service object with typesafe constants and attributes
* `muina` CLI: to copy bundled rbi file


### `Muina::Value`

Value objects are one of the basic building blocks used in Domain Driven Design. They are immutable objects
whose equality is determined by the equality of its attributes and have no inherent identity.

`Muina::Value` leverages some of the modules used to build `T::Struct` so by declaring attributes with
`.const` you get a standard and typesafe initializer.

#### Examples

##### Definition

Use `.const` just as you would on a `T::Struct`.

```ruby
class RGB < Muina::Value
  const :red,   Integer
  const :green, Integer
  const :blue,  Integer
end
```

##### Creation

Build instances with `.new` and key arguments:
```ruby
rgb = RGB.new(red: 10, green: 10, blue: 10)
```

Functionaly create new instances with modified attributes with `#with`:
```ruby
rgb.with(red: 20) # => <RGB red=20 green=10 blue=10>
```

##### Serialization
Serialize with `#serialize`.
Note that keys are symbols as opposed to `T::Struct#serialize` strings.
```ruby
rgb.serialize # => { red: 10, green: 10, blue: 10 }
```

### `Muina::Result`

This is not a DDD pattern, but actually the implementation of a monad.

Result objects encode the result of an operation that can have two (or two sets of) possible outcomes:
- a succesful operation will return some kind of value,
- a failed operation will return some kind of useful error object.

This means that when you wrap some code arround `Muina::Result() { ... }` it will either return:
- an instance of `Muina::Result::Success` containing the successful return value or,
- an instance of `Muina::Result::Failure` containing the error object that would have otherwise been raised.

To retrieve values or errors you use different methods that compel you to safely handle errors. These methods
will behave differently depending on if the result is successful or failed.


#### Examples

##### Creation

Use `Muina::Result() { ... }` to create result objects. If the block successfully returns a value, it will be
wrapped around a `Muina::Result::Success` object, on the other hand if any error is raised, the error object
will be wrapped around a `Muina::Result::Failure`.
```ruby
Muina::Result() { 1 } # => <Muina::Result::Success value=1>
Muina::Result() { raise StandardError, 'error message' } # => <Muina::Resul::Failure error=<StandardError message="error message">>
```

You can, however, directly create both successful and failed instances direclty by using either
`Muina::Success(value)` or `Muina::Error(error)`. 

**Note:** this API is still unstable and might change in the future.

**Note:** that the failure side doesn't have to contain an **error object**, it could be anything else too.

##### Safe handling

To safely handle both the succesful case and the failed case you can use the methods `#and_then` and `#or_else`.
Chaining them while providing a block to each one you would be properly handling both cases:
```ruby
success_result = Muina::Success(:success)
failure_result = Muina::Failure(:error)

success_result.and_then { |val| puts val }.or_else { |err| puts err }
=> :success # gets put

failure_result.and_then { |val| puts val }.or_else { |err| puts err }
=> :failure # gets put
```

Note that the result value of both method is the return object itself, not the return of the block,
so they can be chained in any order, and even multiple times each one.

##### Safe retrieval

To safely unwrap the value or error contained in a `Muina::Result` object, you can use `#value_or` and `#error_or`:
```ruby
success_result = Muina::Success(1)
failure_result = Muina::Failure(1) 

success_result.value_or(2) # => 1
failure_result.value_or(2) # => 2

success_result.error_or(2) # => 2
failure_result.error_or(2) # => 1
```

##### Unsafe handling

If you are sure whether you are handling a success or failure, you might want to act on the value/error
or raise if by any chance things are not what they are supossed to. You can do this using either `#and_then!` or
`#or_else!`. These are not chainable and always return nil.

```ruby
success_result = Muina::Success(:success)
failure_result = Muina::Failure(:error)

success_result.and_then! { |val| puts val }
=> :success # gets put

success_result.or_else! { |err| puts err }
=> # an error gets raised

failure_result.and_then! { |val| puts val }
=> # an error gets raised

failure_result.or_else! { |err| puts err }
=> :error # gets put
```

##### Unsafe retrieval

If you are sure whether you are handling a success or failure, you might want to retrieve the value/error
without providing an alternative value. You can do this using either `#value!` or `#error!`. These methods
will **raise** when used on the wrong case. You should avoid doing this as much as you can.
```ruby
success_result = Muina::Success(1)
failure_result = Muina::Failure(1)

success_result.value! # => 1
failure_result.value! # raises an error

success_result.error! # raises an error (not the contained error tho)
failure_result.error! # => 1
```

### `Muina::PrivateCreation`

This is a small module you can `include` into classes to make both `.allocate` and `.new` private
class methods. This is an easy way to disable direct instantiation of objects. Used by `Muina::Service`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rake spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`. 
To release a new version, update the version number in `version.rb`, and then run `bin/rake release`, 
which will create a git tag for the version, push git commits and the created tag, 
and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vaporyhumo/muina.
This project is intended to be a safe, welcoming space for collaboration.
