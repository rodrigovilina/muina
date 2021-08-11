# typed: false
# frozen_string_literal: true

class StaticFailure < Muina::Action
  failure { 1 }
end

RSpec.describe StaticFailure do
  it 'returns a Failure with value 1', aggregate_failures: true do
    result = described_class.call

    expect(result).to be_a(Muina::Result)

    expect { result.error! }.to raise_error(Muina::Error)
    expect { result.value! }.to raise_error(Muina::Error)
  end
end
