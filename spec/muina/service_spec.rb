# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Service do
  let(:one) do
    Class.new(described_class) do
      def perform
        1
      end
    end
  end
  let(:adder) do
    Class.new(described_class) do
      const :a, Integer
      const :b, Integer

      def perform
        a + b
      end
    end
  end
  let(:optional) do
    Class.new(described_class) do
      arguments :a, { b: 1, c: 2 }

      def perform
        a + b + c
      end
    end
  end

  def is_callable(service, params, expected)
    expect(service.(params)).to eq(expected)
    expect(service.call(params)).to eq(expected)
    expect(service[params]).to eq(expected)
  end

  describe '.allocate' do
    it 'is private' do
      expect { adder.allocate }.to raise_error(NoMethodError)
    end
  end

  describe '.new' do
    it 'is private' do
      expect { adder.new(a: 1, b: 1) }.to raise_error(NoMethodError)
    end
  end

  describe '.call' do
    it 'can be called without arguments' do
      expect(one.call).to eq(1)
    end

    it 'can be called with required arguments', aggregate_failures: true do
      is_callable(adder, { a: 1, b: 2 }, 3)
    end

    context 'when #perform is not implemented' do
      it 'raises NotImplementedError' do
        service = Class.new(described_class)
        expect { service.call }.to raise_error(NotImplementedError)
      end
    end
  end

  describe '.arguments' do
    it 'can declare optional arguments', aggregate_failures: true do
      is_callable(optional, { a: 1, b: 2 }, 5)
    end
  end
end
