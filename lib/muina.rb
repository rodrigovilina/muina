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

module Muina
  class Error < StandardError; end

  class TestError < StandardError; end
end
M = Muina

# Eager load all code
loader.eager_load
