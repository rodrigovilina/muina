# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action::Query do
  describe '.new' do
    specify { expect(described_class.new(name: :one, step: proc {})).to be_a(described_class) }
  end

  describe '.call' do
    it do
      instance = Object.new
      query = described_class.new(name: :one, step: proc { 1 })
      expect(query.call(instance)).to be(1)
      expect(instance.instance_variable_get(:@one)).to be(1)
    end
  end
end
