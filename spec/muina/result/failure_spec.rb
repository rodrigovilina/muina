# frozen_string_literal: true

RSpec.describe Muina::Result::Failure do
  describe '#value!' do
    it 'returns the inner value' do
      result = Muina::Result.failure(true)

      expect { result.value! }.to raise_error RuntimeError
    end
  end

  describe '#error!' do
    it 'raises an error' do
      result = Muina::Result.failure(true)

      expect(result.error!).to be true
    end
  end
end
