# frozen_string_literal: true

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

module Muina
  Error = Class.new(StandardError)
end

loader.eager_load
