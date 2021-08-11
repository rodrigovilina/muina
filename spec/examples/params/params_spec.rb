# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Params do
  it do
    asdf = Class.new(described_class) do
      const :int, Integer
    end
    asdf.extract(int: '1')
  end

  it do
    asdf = Class.new(described_class) do
      const :int, Integer
    end
    asdf.extract(ActionController::Parameters.new(int: '1'))
  end
end
