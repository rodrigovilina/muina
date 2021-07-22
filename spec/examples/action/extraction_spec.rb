# typed: false
# frozen_string_literal: true

class Extraction < Muina::Action
  parameters { const :a, Integer }

  result { a }
end

RSpec.describe Extraction do
  context 'with hash' do
    it 'returns a result with value 1' do
      expect(described_class.call(a: '1').value!).to be(1)
    end
  end

  context 'with action controller params' do
    it 'returns a result with value 1' do
      expect(described_class.call(ActionController::Parameters.new({ a: '1' })).value!).to be(1)
    end
  end
end
