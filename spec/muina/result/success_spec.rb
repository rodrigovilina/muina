# frozen_string_literal: true

RSpec.describe Muina::Result::Success do
  describe '#value!' do
    it 'returns the inner value' do
      result = Muina::Result.success(true)

      expect(result.value!).to be true
    end
  end

  describe '#error!' do
    it 'raises an error' do
      result = Muina::Result.success(true)

      expect { result.error! }
        .to raise_error RuntimeError
    end
  end
end
