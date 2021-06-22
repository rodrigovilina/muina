# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Params do
  describe '.extract' do
    context 'when not inherited' do
      it 'builds from an ActionController::Parameters' do
        params = ActionController::Parameters.new({})
        expect(described_class.extract(params)).to be_a(described_class)
      end

      it 'builds successfully from a Hash' do
        params = {}
        expect(described_class.extract(params)).to be_a(described_class)
      end
    end

    context 'when inherited' do
      it 'builds successfully from an ActionController::Parameters', aggregate_failures: true do
        klass         = Class.new(described_class) { const :x, Integer }
        params        = ActionController::Parameters.new({ x: 1 })
        instance      = klass.extract(params)
        expect(instance).to be_a(klass)
        expect(instance.x).to be(1)
      end

      it 'builds successfully from a Hash', aggregate_failures: true do
        klass = Class.new(described_class) { const :x, Integer }
        params = { x: 1 }
        instance = klass.extract(params)
        expect(instance).to be_a(klass)
        expect(instance.x).to be(1)
      end
    end
  end
end
