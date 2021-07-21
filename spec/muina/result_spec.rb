# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Result do
  describe '.[]' do
    context 'when subclassed' do
      specify { expect { described_class[Integer, Integer].success(1.0) }.to raise_error(TypeError) }
      specify { expect { described_class[Integer, Integer].failure(1.0) }.to raise_error(TypeError) }
    end

    context 'when given nil values' do
      specify { expect { described_class[Integer, Integer].success(nil) }.to raise_error(TypeError) }
      specify { expect { described_class[Integer, Integer].failure(nil) }.to raise_error(TypeError) }
    end

    specify { expect(described_class[Integer, Integer].success(1)).to be_a(Muina::Result::Success) }
    specify { expect(described_class[Integer, Integer].success(1).class).not_to be(Muina::Result::Success) }
    specify { expect(described_class[Integer, Integer].success(1).value!).to be(1) }
    specify { expect(described_class[Integer, Integer].failure(1).error!).to be(1) }

    specify { expect { described_class[Integer, Integer].success(1).value }.to raise_error(NoMethodError) }
    specify { expect { described_class[Integer, Integer].failure(1).error }.to raise_error(NoMethodError) }

    specify { expect { described_class[Integer, Integer] }.not_to raise_error }
    specify { expect { described_class[Integer, Integer].success(1).error! }.to raise_error(Muina::Error) }
    specify { expect { described_class[Integer, Integer].failure(1).value! }.to raise_error(Muina::Error) }
    specify { expect { described_class[Integer, Integer].success(1).error }.to raise_error(NoMethodError) }
    specify { expect { described_class[Integer, Integer].failure(1).value }.to raise_error(NoMethodError) }
  end

  describe '.Null' do
    it do
      expect(described_class.Null).to be_a(Muina::Result::Null)
    end
  end
end
