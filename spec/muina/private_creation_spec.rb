# typed: false
# frozen_string_literal: true

RSpec.describe Muina::PrivateCreation do
  subject(:klass) { Class.new.tap { |k| k.include(described_class) } }

  describe '.allocate' do
    it 'is private' do
      expect { klass.allocate }.to raise_error(NoMethodError)
    end
  end

  describe '.new' do
    it 'is private' do
      expect { klass.new }.to raise_error(NoMethodError)
    end
  end
end
