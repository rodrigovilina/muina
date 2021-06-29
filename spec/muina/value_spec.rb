# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Value do
  let(:point_klass) do
    Class.new(described_class) do
      const :x, Integer
      const :y, Integer
    end
  end

  describe '#instance_variable_set' do
    it 'raises FrozenError' do
      expect { point_klass.new(x: 1, y: 1).instance_variable_set(:@x, 2) }.to raise_error(FrozenError)
    end
  end

  describe '.new' do
    it 'can have no constants' do
      value = Class.new(described_class)
      expect(value.new).to be_a(value)
    end

    it 'builds successfully', aggregate_failures: true do
      point = point_klass.new(x: 1, y: 1)
      expect(point).to be_a(point_klass)
      expect(point.x).to eq(1)
      expect(point.y).to eq(1)
    end
  end

  def test_unequality(klass, method)
    expect(klass.new(x: 1, y: 1).__send__(method, klass.new(x: 1, y: 1))).to be(false)
  end

  describe '#==' do
    it 'is true if all members are equal' do
      expect(point_klass.new(x: 1, y: 1)).to eq(point_klass.new(x: 1, y: 1)) # rubocop:disable RSpec/IdenticalEqualityAssertion
    end
  end

  describe '#eql?' do
    it 'is false' do
      test_unequality(point_klass, :eql?)
    end
  end

  describe '#equal?' do
    it 'is false' do
      test_unequality(point_klass, :equal?)
    end
  end
end
