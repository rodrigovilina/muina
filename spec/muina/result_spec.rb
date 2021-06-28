# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Result do # rubocop:todo Metrics/BlockLength
  describe '.[]' do
    context 'when subclassed' do
      specify { expect { described_class[Integer, Integer].success(1.0) }.to raise_error(TypeError) }
      specify { expect { described_class[Integer, Integer].failure(1.0) }.to raise_error(TypeError) }
    end

    context 'when given nil values' do
      specify { expect { described_class[Integer, Integer].success(nil) }.to raise_error(TypeError) }
      specify { expect { described_class[Integer, Integer].failure(nil) }.to raise_error(TypeError) }
    end

    specify { expect(described_class[Integer, Integer].success(1)).to be_a(described_class) }
    specify { expect(described_class[Integer, Integer].success(1).class).not_to be(described_class) }
    specify { expect(described_class[Integer, Integer].success(1).value!).to be(1) }
    specify { expect(described_class[Integer, Integer].failure(1).error!).to be(1) }

    specify { expect(described_class.success(1).value!).to be(1) }
    specify { expect(described_class.failure(1).error!).to be(1) }

    specify { expect { described_class[Integer, Integer] }.not_to raise_error }
    specify { expect { described_class[Integer, Integer].success(1).error! }.to raise_error(Muina::Error) }
    specify { expect { described_class[Integer, Integer].failure(1).value! }.to raise_error(Muina::Error) }
    specify { expect { described_class[Integer, Integer].success(1).error }.to raise_error(NoMethodError) }
    specify { expect { described_class[Integer, Integer].failure(1).value }.to raise_error(NoMethodError) }
  end

  describe '.failure' do
    it 'creates a failed result with the given error' do
      error = StandardError.new
      failure = described_class[T.untyped, StandardError].failure(error)
      expect(failure.error!).to be(error)
    end

    it do
      error = StandardError.new
      failure = described_class[T.untyped, StandardError].failure(error)
      expect { failure.value! }.to raise_error(Muina::Error)
    end
  end

  describe '.success' do
    it 'creates a successful result with the given value' do
      value = 1
      success = described_class[Integer, T.untyped].success(value)
      expect(success.value!).to be(value)
    end

    it do
      value = 1
      success = described_class[Integer, T.untyped].success(value)
      expect { success.error! }.to raise_error(Muina::Error)
    end
  end

  describe '#and_then' do
    it do
      a_value = 1
      invitation = instance_spy(IO, 'invitation')
      described_class.success(a_value).and_then { |value| invitation.puts(value) }
      expect(invitation).to have_received(:puts).with(a_value)
    end

    it do
      a_value = 1
      invitation = instance_spy(IO, 'invitation')
      described_class.failure(a_value).and_then { |value| invitation.puts(value) }.or_else
      expect(invitation).not_to have_received(:puts)
    end

    it do
      a_value = 1
      instance = described_class.success(a_value)
      expect(instance.and_then).to be(instance)
    end
  end

  describe '#or_else' do
    it do
      a_value = 1
      invitation = instance_spy(IO, 'invitation')
      described_class.failure(a_value).and_then.or_else { |value| invitation.puts(value) }
      expect(invitation).to have_received(:puts).with(a_value)
    end

    it do
      a_value = 1
      invitation = instance_spy(IO, 'invitation')
      described_class.success(a_value).and_then { |_value| nil }.or_else { |value| invitation.puts(value) }
      expect(invitation).not_to have_received(:puts)
    end

    it do
      a_value = 1
      instance = described_class.failure(a_value)
      expect(instance.or_else).to be(instance)
    end
  end

  describe '#value!' do
    it do
      failure = described_class.failure(StandardError.new)
      expect { failure.value! }.to raise_error(Muina::Error)
    end

    it 'creates a successful result with the given value' do
      value = 1
      success = described_class.success(value)
      expect(success.value!).to be(value)
    end
  end

  describe '#error!' do
    it 'creates a failed result with the given error' do
      error = StandardError.new
      failure = described_class.failure(error)
      expect(failure.error!).to be(error)
    end

    it do
      success = described_class.success(1)
      expect { success.error! }.to raise_error(Muina::Error)
    end
  end
end
