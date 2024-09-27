# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Muina
  # Top level error class for {Muina}
  Error = Class.new(StandardError)
end

require_relative 'muina/maybe'
require_relative 'muina/result'
