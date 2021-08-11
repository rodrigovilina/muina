# typed: false
# frozen_string_literal: true

class Adder < Muina::Service
  const :a, Integer
  const :b, Integer

  def perform
    a + b
  end
end

RSpec.describe Adder do
  it do
    expect(described_class.call(a: 1, b: 2)).to be(3)
  end
end
