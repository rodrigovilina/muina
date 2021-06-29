# typed: false
# frozen_string_literal: true

class StaticResult < M::Action
  result { 1 }
end

RSpec.describe StaticResult do
  it 'returns a result with value 1' do
    expect(described_class.call.value!).to be(1)
  end
end
