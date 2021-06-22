# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Utils do
  describe '.cast_to_error' do
    it 'raises on object' do
      expect { described_class.cast_to_errors(1) }.to raise_error(Muina::Error)
    end

    it 'maps class to class' do
      expect(described_class.cast_to_errors(StandardError)).to match([StandardError])
    end

    it 'maps T.untyped to StandardError' do
      expect(described_class.cast_to_errors(T.untyped)).to match([StandardError])
    end

    it 'maps an array to itself' do
      expect(described_class.cast_to_errors([Integer, StandardError])).to match([Integer, StandardError])
    end

    it 'maps a union with T.untyped to StandardError' do
      expect(described_class.cast_to_errors(T.any(T.untyped, Integer))).to match([StandardError, Integer])
    end

    it 'maps a union to its raw classes' do
      expect(described_class.cast_to_errors(T.any(Integer, Float))).to match([Integer, Float])
    end
  end
end
