# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Result::Success do
  describe '#and_then' do
    it do
      a_value = 1
      invitation = instance_spy(IO, 'invitation')
      Muina::Success(a_value).and_then { |value| invitation.puts(value) }
      expect(invitation).to have_received(:puts).with(a_value)
    end

    it do
      a_value = 1
      instance = Muina::Success(a_value)
      expect(instance.and_then).to be(instance)
    end
  end

  describe '#or_else' do
    it do
      invitation = instance_spy(IO, 'invitation')
      Muina::Success(Object).or_else { |value| invitation.puts(value) }
      expect(invitation).not_to have_received(:puts)
    end

    it do
      instance = Muina::Success(Object)
      expect(instance.or_else).to be(instance)
    end
  end

  describe '#value!' do
    it 'creates a successful result with the given value' do
      value = 1
      success = Muina::Success(value)
      expect(success.value!).to be(value)
    end
  end

  describe '#error!' do
    it 'creates a failed result with the given error' do
      success = Muina::Success(Object)
      expect { success.error! }.to raise_error(Muina::Error)
    end
  end
end
