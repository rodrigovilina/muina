# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action do
  describe '.result' do
    context 'when used twice' do
      let(:klass) do
        Class.new(described_class) do
          result { nil }
          result { nil }
        end
      end

      it { expect { klass }.to raise_error(Muina::Action::DoubleResultError) }
    end

    context 'when used once' do
      let(:klass) do
        Class.new(described_class) do
          result { nil }
        end
      end

      it { expect(klass.call.value!).to be_nil }
    end
  end
end
