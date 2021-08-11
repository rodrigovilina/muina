# typed: strict
# frozen_string_literal: true

# Load dependencies
require 'action_controller'
require 'action_controller/metal/exceptions'
require 'sorbet-runtime'
require 'sorbet-rails/typed_params'
require 'sorbet-struct-comparable'

# Require Module monkeypatch
require 'muina/module'

# Setup zeitwork loader
require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
module_ext = "#{__dir__}/muina/module.rb"
loader.ignore(module_ext)
loader.setup

# Top level module
module Muina
  class Error < StandardError; end

  def self.Success(value) # rubocop:disable Naming/MethodName
    Result::Success.__send__(:new, value: value)
  end

  def self.Failure(error) # rubocop:disable Naming/MethodName
    Result::Failure.__send__(:new, error: error)
  end

  def self.Result(&blk) # rubocop:disable Naming/MethodName
    Success(blk[])
  rescue StandardError => e
    Failure(e)
  end
end
M = Muina

# Eager load all code
loader.eager_load
