# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Entity do
  let(:klass) { Class.new(described_class) }

  specify { expect(klass.new(id: 1)).to be_a(klass) }

  describe('#serialize') { specify { expect(klass.new(id: 1).serialize).to match({ id: 1 }) } }

  describe('#with') { specify { expect(klass.new(id: 1).with(id: 2).id).to be(2) } }
end
