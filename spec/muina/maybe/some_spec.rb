# frozen_string_literal: true

RSpec.describe Muina::Maybe::Some do
  let(:object) { Object.new                   }
  let(:some)   { Muina::Maybe::return(object) }

  describe '#some?' do
    specify do
      expect(some.some?).to be true
    end
  end

  describe '#none?' do
    specify do
      expect(some.none?).to be false
    end
  end

  describe '#value!' do
    specify do
      expect(some.value!).to be object
    end
  end

  describe '#value_or' do
    specify do
      expect(some.value_or(Object.new)).to be object
    end
  end

  describe '#value_or_yield' do
    specify do
      expect(some.value_or_yield { true }).to be object
    end
  end

  describe '#value_or_nil' do
    specify do
      expect(some.value_or_nil).to be object
    end
  end

  describe '#and_then' do
    specify aggregate_failures: true do
      allow(object).to receive(:inspect)
      result = some.and_then { |o| o.inspect }
      expect(object).to have_received(:inspect)
      expect(result).to be some
    end
  end

  describe '#or_else' do
    specify aggregate_failures: true do
      allow(object).to receive(:inspect)
      result = some.or_else { object.inspect }
      expect(object).not_to have_received(:inspect)
      expect(result).to be some
    end
  end

  describe '#map' do
    specify do
      some = Muina::Maybe::return(1)
      result = some.map { |i| i + 1 }
                   .value!
      expect(result).to be 2
    end
  end

  describe '#map_none' do
    specify do
      result = some.map_none { 1 }
                   .value!
      expect(result).to be object
    end
  end

  describe '#bind' do
    specify do
      some = Muina::Maybe::return(1)
      result = some.bind { |i| Muina::Maybe.return(i + 1) }
                   .value!
      expect(result).to be 2
    end
  end

  describe '#bind_none' do
    specify do
      result = some.bind_none { Muina::Maybe.return(i + 1) }
      expect(result).to be some
    end
  end
end
