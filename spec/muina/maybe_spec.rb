# frozen_string_literal: true

RSpec.describe Muina::Maybe do
  let(:object) { Object.new                      }
  let(:some)   { described_class::return(object) }
  let(:none)   { described_class::none           }

  describe '#initialize' do
    specify do
      expect(some).to be_frozen
    end

    specify do
      expect(some.value!).to be object
    end

    specify do
      expect(none).to be_frozen
    end
  end

  describe '#some?' do
    specify do
      expect(some.some?).to be true
    end

    specify do
      expect(none.some?).to be false
    end
  end

  describe '#none?' do
    specify do
      expect(some.none?).to be false
    end

    specify do
      expect(none.none?).to be true
    end
  end

  describe '#value!' do
    specify do
      expect(some.value!).to be object
    end

    specify do
      expect { none.value! }
        .to raise_error Muina::Maybe::UnwrappingError
    end
  end

  describe '#value_or' do
    specify do
      expect(some.value_or(Object.new)).to be object
    end

    specify do
      object = Object.new
      expect(none.value_or(object)).to be object
    end
  end

  describe '#value_or_yield' do
    specify do
      expect(some.value_or_yield { true }).to be object
    end

    specify do
      expect(none.value_or_yield { object }).to be object
    end
  end

  describe '#value_or_nil' do
    specify do
      expect(some.value_or_nil).to be object
    end

    specify do
      expect(none.value_or_nil).to be_nil
    end
  end

  describe '#and_then' do
    specify do
      allow(object).to receive(:inspect)
      result = some.and_then { |o| o.inspect }
      expect(object).to have_received(:inspect)
      expect(result).to be some
    end

    specify do
      allow(object).to receive(:inspect)
      result = none.and_then { |o| o.inspect }
      expect(object).not_to have_received(:inspect)
      expect(result).to be none
    end
  end

  describe '#or_else' do
    specify do
      allow(object).to receive(:inspect)
      result = some.or_else { object.inspect }
      expect(object).not_to have_received(:inspect)
      expect(result).to be some
    end

    specify do
      allow(object).to receive(:inspect)
      result = none.or_else { object.inspect }
      expect(object).to have_received(:inspect)
      expect(result).to be none
    end
  end

  describe '#map' do
    specify do
      some = described_class::return(1)
      result = some.map { |i| i + 1 }
                   .value!
      expect(result).to be 2
    end

    specify do
      result = none.map { |i| i + 1 }
      expect(result).to be none
    end
  end

  describe '#map_none' do
    specify do
      result = some.map_none { 1 }
                   .value!
      expect(result).to be object
    end

    specify do
      result = none.map_none { 1 }
                   .value!
      expect(result).to be 1
    end
  end

  describe '#bind' do
    specify do
      some = described_class::return(1)
      result = some.bind { |i| described_class.return(i + 1) }
                   .value!
      expect(result).to be 2
    end

    specify do
      result = none.bind { |i| described_class.return(i + 1) }
      expect(result).to be none
    end
  end

  describe '#bind_none' do
    specify do
      result = some.bind_none { described_class.return(i + 1) }
      expect(result).to be some
    end

    specify do
      result = none.bind_none { described_class.return(1) }
                   .value!
      expect(result).to be 1
    end
  end

  describe '#==' do
    specify do
      expect(some).not_to be_nil
    end

    specify do
      left  = Maybe.return(1)
      right = Maybe.return(2)

      expect(left).not_to eq right
    end

    specify do
      expect(some).to eq described_class.return(object)
    end

    specify do
      expect(some).not_to eq described_class.none
    end

    specify do
      expect(none).to eq described_class.none
    end

    specify do
      expect(none).not_to eq described_class.some(1)
    end

    specify do
      expect(none).not_to be_nil
    end
  end
end
