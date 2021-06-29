# typed: false
# frozen_string_literal: true

class Extraction < M::Action
  const :a, Integer

  result { a }
end

RSpec.describe Extraction do
  it 'returns a result with value 1' do
    expect(described_class.call(a: 1).value!).to be(1)
  end
end
