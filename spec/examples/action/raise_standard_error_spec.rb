# typed: false
# frozen_string_literal: true

class RaiseStandardError < Muina::Action
  result { raise StandardError }
end

RSpec.describe RaiseStandardError do
  it '2', aggregate_failures: true do
    result = described_class.call
    expect(result).to be_an(Muina::Result)
    expect { result.value! }.to raise_error(Muina::Error)
    expect(result.error!).to be_an(StandardError)
  end
end
