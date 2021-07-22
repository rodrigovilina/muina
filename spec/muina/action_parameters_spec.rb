# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action do
  describe '.parameters' do
    let(:klass) do
      Class.new(described_class) do
        parameters { const :hola, String }
      end
    end

    it '', aggregate_failures: true do
      expect(klass.parameters).to be_a(Class)
      expect(klass.parameters.new(hola: 'hola')).to be_a(T::Struct)
      expect(klass.props.size).to be(1)
      expect(T::Struct.props.size).to be(0)
    end
  end
end
