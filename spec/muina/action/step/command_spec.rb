# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action::Step::Command do
  describe '.new' do
    specify { expect(described_class.new(step: proc {})).to be_a(described_class) }
  end

  describe '.call' do
    let(:klass) do
      Class.new do
        def hola; end
      end
    end

    it do
      expect(described_class.new(step: proc { 1 }).call(1)).to eq(nil)
    end

    it do
      object = class_double(Object, new: nil)
      described_class.new(step: proc { object.new }).call(1)
      expect(object).to have_received(:new)
    end

    it do
      object = instance_double(klass)
      allow(object).to receive(:hola)
      described_class.new(step: proc { hola }).call(object)
      expect(object).to have_received(:hola)
    end

    it do
      expect(described_class.new(step: proc { 1 }).call).to eq(nil)
    end

    it do
      expect { described_class.new(step: proc { new }).call }.not_to raise_error
    end
  end
end
