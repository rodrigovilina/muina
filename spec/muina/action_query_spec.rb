# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action do
  describe '.query' do
    let(:one) do
      Class.new(described_class) do
        query(:one) { 1 }
        result { one }
      end
    end
    let(:two) do
      Class.new(described_class) do
        query(:one) { 1 }
        query(:two) { one + 1 }
        result { two }
      end
    end

    it 'one', aggregate_failures: true do
      result = one.call
      expect(result).to be_an(M::Result)
      expect(result.value).to be(1)
      expect { result.error }.to raise_error(Muina::Error)
    end

    it 'two', aggregate_failures: true do
      result = two.call
      expect(result.value).to be(2)
    end
  end
end
