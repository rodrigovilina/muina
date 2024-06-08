# frozen_string_literal: true

RSpec.describe Muina::Result::Failure do
  let(:object)  { Object.new                     }
  let(:failure) { Muina::Result::failure(object) }

  describe '#initialize' do
    specify do
      expect(failure).to be_frozen
    end

    specify do
      expect(failure.error!).to be object
    end
  end

  describe '#value!' do
    it 'returns the inner value' do
      result = Muina::Result.failure(true)

      expect { result.value! }
        .to raise_error RuntimeError
    end
  end

  describe '#error!' do
    it 'raises an error' do
      result = Muina::Result.failure(true)

      expect(result.error!).to be true
    end
  end
end
