# typed: false
# frozen_string_literal: true

IntegerIntegerResult = Muina::Result[Integer, Integer]

RSpec.describe IntegerIntegerResult do
  it do
    expect { described_class.success(nil) }.to raise_error(TypeError)
  end

  it do
    expect { described_class.failure(nil) }.to raise_error(TypeError)
  end

  it do
    expect(described_class.success(1)).to be_an(Muina::Result::Success)
  end

  it do
    expect(described_class.failure(1)).to be_an(Muina::Result::Failure)
  end
end
