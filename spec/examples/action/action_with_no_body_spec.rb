# typed: false
# frozen_string_literal: true

class ActionWithNoBody < M::Action
end

RSpec.describe ActionWithNoBody do
  it 'returns an invalid result object', aggregate_failures: true do
    expect { described_class.call.value! }.to raise_error(Muina::Error)
    expect { described_class.call.error! }.to raise_error(Muina::Error)
  end
end
