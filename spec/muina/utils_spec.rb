# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Utils do
  describe '.cast_to_errors' do
    it 'raises on object' do
      expect { described_class.cast_to_errors(1) }.to raise_error(Muina::Error)
    end

    it 'maps class to class' do
      expect(described_class.cast_to_errors(StandardError)).to match([StandardError])
    end

    it 'uniques the result' do
      expect(described_class.cast_to_errors([StandardError, StandardError])).to match([StandardError])
    end

    it 'maps module to module' do
      module_k = Module.new
      expect(described_class.cast_to_errors(module_k)).to match([module_k])
    end

    it 'raises on nil' do
      expect { described_class.cast_to_errors(nil) }.to raise_error(Muina::Error)
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

  describe '.cast_union_to_errors' do
    it do
      expect(described_class.cast_union_to_errors(T.any(Integer, Float))).to eq([Integer, Float])
    end
  end

  describe '.errors_rescue_module' do
    it do
      expect(described_class.errors_rescue_module(Integer).===(1)).to be(true) # rubocop:todo Style/CaseEquality
    end

    it do
      # rubocop:todo Style/CaseEquality
      expect(described_class.errors_rescue_module([Integer, T.untyped]).===(StandardError.new)).to be(true)
      # rubocop:enable Style/CaseEquality
    end

    it do
      expect(described_class.errors_rescue_module(Float).===(1)).to be(false) # rubocop:todo Style/CaseEquality
    end
  end
end
