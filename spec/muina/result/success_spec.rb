# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Result::Success do
  include_context 'acts as result', :Success, :and_then, :or_else, :value!, :error!
end
