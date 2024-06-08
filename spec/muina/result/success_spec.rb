# frozen_string_literal: true

RSpec.describe Muina::Result::Success do
  let(:object)  { Object.new                     }
  let(:success) { Muina::Result::success(object) }

  describe '#initialize' do
    specify do
      expect(success).to be_frozen
    end

    specify do
      expect(success.value!).to be object
    end
  end

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
