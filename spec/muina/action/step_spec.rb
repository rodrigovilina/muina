# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action::Step do
  xdescribe '.fail!' do
    it do
      expect { described_class.fail!(StandardError.new, Integer, Muina::Error) }.to raise_error(TypeError)
    end

    it do
      expect(described_class.fail!(StandardError.new, Integer, StandardError).error).to be_a(StandardError)
    end
  end

  xdescribe '.call' do
    it '', aggregate_failures: true do
      expect(described_class.call(-> { 1 }, Integer, Integer).call).to be_a(Muina::Result)
    end

    it 'is type safe on the value side', aggregate_failures: true do
      expect { described_class.call(-> {}, Integer, Integer).call }.to raise_error(TypeError)
    end

    it 'rescues the raised error if type matches', aggregate_failures: true do
      expect(described_class.call(-> { raise KeyError }, Integer, KeyError).call).to be_a(Muina::Result)
    end

    it 'rescues standard error on untyped failure', aggregate_failures: true do
      step = described_class.call(-> { raise StandardError }, Integer, T.untyped)
      result = step.call
      expect(result).to be_a(Muina::Result)
      expect(result.error).to be_a(StandardError)
    end

    it 'raises errors that do not match', aggregate_failures: true do
      expect do
        described_class.call(-> { raise Muina::TestError }, Integer, KeyError).call
      end.to raise_error(Muina::TestError)
    end
  end
end
