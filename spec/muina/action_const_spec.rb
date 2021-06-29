# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action do
  describe '.const' do
    let(:one) do
      Class.new(described_class) do
        const :number, Integer

        result { number }
      end
    end

    it 'one', aggregate_failures: true do
      result = one.call(number: 1)
      expect(result).to be_an(M::Result)
      expect(result.value!).to be(1)
      expect { result.error! }.to raise_error(Muina::Error)
    end
  end
end
