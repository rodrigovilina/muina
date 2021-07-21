# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Result::Failure do
  include_context 'acts as result', :Failure, :or_else, :and_then, :error!, :value!
end
