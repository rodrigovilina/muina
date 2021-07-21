# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action do
  describe '.command' do
    let(:object) { class_double(Object, new: nil) }
    let(:klass) do
      iobject = object
      Class.new(described_class) do
        command(:one) { iobject.new }
        command { nil }
      end
    end

    it 'one', aggregate_failures: true do
      klass.call
      expect(object).to have_received(:new)
    end
  end
end
