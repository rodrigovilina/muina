# typed: false
# frozen_string_literal: true

class StaticFailure < Muina::Action
  failure { 1 }
end

RSpec.describe StaticFailure do
  it 'returns a Failure with value 1', aggregate_failures: true do
    result = described_class.call
    expect(result).to be_an(Muina::Result)
    expect(result.error!).to be(1)
    expect { result.value! }.to raise_error(Muina::Error)
  end
end
