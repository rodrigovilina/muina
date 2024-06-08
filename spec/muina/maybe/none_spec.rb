# frozen_string_literal: true

RSpec.describe Muina::Maybe::None do
  let(:none) { Muina::Maybe::none }

  describe '#some?' do
    specify do
      expect(none.some?).to be false
    end
  end

  describe '#none?' do
    specify do
      expect(none.none?).to be true
    end
  end

  describe '#value!' do
    specify do
      expect { none.value! }
        .to raise_error RuntimeError
    end
  end

  describe '#value_or' do
    specify do
      object = Object.new
      expect(none.value_or(object)).to be object
    end
  end

  describe '#value_or_yield' do
    specify do
      object = Object.new
      expect(none.value_or_yield { object }).to be object
    end
  end

  describe '#value_or_nil' do
    specify do
      expect(none.value_or_nil).to be_nil
    end
  end

  describe '#and_then' do
    specify aggregate_failures: true do
      object = Object.new
      allow(object).to receive(:inspect)
      result = none.and_then { |o| o.inspect }
      expect(object).not_to have_received(:inspect)
      expect(result).to be none
    end
  end

  describe '#or_else' do
    specify aggregate_failures: true do
      object = Object.new
      allow(object).to receive(:inspect)
      result = none.or_else { object.inspect }
      expect(object).to have_received(:inspect)
      expect(result).to be none
    end
  end

  describe '#map' do
    specify do
      result = none.map { |i| i + 1 }
      expect(result).to be none
    end
  end

  describe '#map_none' do
    specify do
      result = none.map_none { 1 }
                   .value!
      expect(result).to be 1
    end
  end

  describe '#bind' do
    specify do
      result = none.bind { |i| Muina::Maybe.return(i + 1) }
      expect(result).to be none
    end
  end

  describe '#bind_none' do
    specify do
      result = none.bind_none { Muina::Maybe.return(1) }
                   .value!
      expect(result).to be 1
    end
  end
end
