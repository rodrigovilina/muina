# typed: false
# frozen_string_literal: true

class FailureAfterFailedResult < Muina::Action
  parameters do
    const :io, IO
  end

  result { raise StandardError }

  failure { io.puts }
end

RSpec.describe FailureAfterFailedResult do
  let(:io) { instance_double(IO) }

  it '', aggregate_failures: true do
    allow(io).to receive(:puts)
    result = described_class.call(io: io)
    expect(io).to have_received(:puts)
    expect(result.error!).to be_nil
  end
end
