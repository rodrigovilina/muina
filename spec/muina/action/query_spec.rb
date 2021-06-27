# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action::Query do
  describe '.new' do
    specify { expect(described_class.new(name: :one, step: proc {})).to be_a(described_class) }
  end

  describe '.call' do
    it 'runs the code and save it into instance variable', aggregate_failures: true do
      instance = Object.new
      query = described_class.new(name: :one, step: proc { 1 })
      expect(query.call(instance)).to be(1)
      expect(instance.instance_variable_get(:@one)).to be(1)
    end

    it 'todo wip 1', aggregate_failures: true do
      query = described_class.new(name: :one, step: proc { 1 })
      expect(query.call).to be(1)
    end

    it 'todo wip 2 ', aggregate_failures: true do
      instance = Object.new.tap { |obj| obj.define_singleton_method(:to_s) { '1' } }
      query = described_class.new(name: :one, step: proc { to_s.to_i + 1 })
      expect(query.call(instance)).to be(2)
      expect(instance.instance_variable_get(:@one)).to be(2)
    end
  end
end
