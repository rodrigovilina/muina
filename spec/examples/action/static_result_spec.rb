# typed: false
# frozen_string_literal: true

class StaticResult < Muina::Action
  result { 1 }
end

RSpec.describe StaticResult do
  it 'returns a result with value 1', aggregate_failures: true do
    result = described_class.call
    expect(result).to be_an(Muina::Result)
    expect(result.value!).to be(1)
    expect { result.error! }.to raise_error(Muina::Error)
  end
end
