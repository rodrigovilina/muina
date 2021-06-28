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
      expect(one.call.value!).to be(1)
    end

    it 'two', aggregate_failures: true do
      expect(two.call.value!).to be(2)
    end
  end
end
