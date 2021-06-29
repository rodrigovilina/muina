# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action::Step do
  describe '#fail!' do
    it do
      expect do
        described_class.new(step: proc {
                                  }, success: Integer, failure: Muina::Error).fail!(StandardError.new)
      end.to raise_error(TypeError)
    end

    it do
      expect(
        described_class.new(
          step: proc {}, success: Integer, failure: StandardError
        ).fail!(StandardError.new).error!
      ).to be_a(StandardError)
    end
  end

  describe '#call' do
    it '2', aggregate_failures: true do
      expect(described_class.new(step: proc { 1 }, success: Integer, failure: Integer).call).to be_a(Muina::Result)
    end

    it 'is type safe on the value side', aggregate_failures: true do
      expect { described_class.new(step: proc {}, success: Integer, failure: Integer).call }.to raise_error(TypeError)
    end

    it '1', aggregate_failures: true do
      expect(
        described_class.new(step: proc { to_s.to_i + 1 }, success: Integer, failure: Integer).call(1).value!
      ).to be(2)
    end

    it 'rescues the raised error if type matches', aggregate_failures: true do # TODO: todo
      expect(described_class.new(step: proc {
                                         raise KeyError
                                       }, success: Integer, failure: KeyError).call(1)).to be_a(Muina::Result)
    end

    it 'rescues standard error on untyped failure', aggregate_failures: true do
      step = described_class.new(step: proc { raise StandardError }, success: Integer, failure: T.untyped)
      result = step.call
      expect(result).to be_a(Muina::Result)
      expect(result.error!).to be_a(StandardError)
    end

    it 'raises errors that do not match', aggregate_failures: true do
      expect do
        described_class.new(step: proc { raise Muina::TestError }, success: Integer, failure: KeyError).call
      end.to raise_error(Muina::TestError)
    end
  end
end
