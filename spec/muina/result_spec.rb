# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Result do
  describe '.[]' do
    context 'when subclassed' do
      specify { expect { described_class[Integer, Integer].success(1.0) }.to raise_error(TypeError) }
      specify { expect { described_class[Integer, Integer].failure(1.0) }.to raise_error(TypeError) }
    end

    context 'when given nil values' do
      specify { expect { described_class[Integer, Integer].success(nil) }.to raise_error(TypeError) }
      specify { expect { described_class[Integer, Integer].failure(nil) }.to raise_error(TypeError) }
    end

    specify { expect { described_class[Integer, Integer] }.not_to raise_error }
    specify { expect(described_class[Integer, Integer].success(1)).to be_a(described_class) }
    specify { expect(described_class[Integer, Integer].success(1).value).to be(1) }
    specify { expect(described_class[Integer, Integer].failure(1).error).to be(1) }
    specify { expect { described_class[Integer, Integer].success(1).error }.to raise_error(Muina::Error) }
    specify { expect { described_class[Integer, Integer].failure(1).value }.to raise_error(Muina::Error) }
  end

  describe '.failure' do
    it 'creates a failed result with the given error' do
      error = StandardError.new
      failure = described_class[T.untyped, StandardError].failure(error)
      expect(failure.error).to be(error)
    end

    it do
      error = StandardError.new
      failure = described_class[T.untyped, StandardError].failure(error)
      expect { failure.value }.to raise_error(Muina::Error)
    end
  end

  describe '.success' do
    it 'creates a successful result with the given value' do
      value = 1
      success = described_class[Integer, T.untyped].success(value)
      expect(success.value).to be(value)
    end

    it do
      value = 1
      success = described_class[Integer, T.untyped].success(value)
      expect(success.value).to be(value)
    end

    it do
      value = 1
      success = described_class[Integer, T.untyped].success(value)
      expect { success.error }.to raise_error(Muina::Error)
    end
  end
end
