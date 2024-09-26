# frozen_string_literal: true

module Muina
  Error = Class.new(StandardError)
end

require_relative 'muina/maybe'
require_relative 'muina/result'
