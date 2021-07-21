# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Result::Failure do
  describe '#and_then' do
    it do
      invitation = instance_spy(IO, 'invitation')
      Muina::Failure(Object).and_then { |error| invitation.puts(error) }
      expect(invitation).not_to have_received(:puts)
    end

    it do
      instance = Muina::Failure(Object)
      expect(instance.and_then).to be(instance)
    end
  end

  describe '#or_else' do
    it do
      a_error = 1
      invitation = instance_spy(IO, 'invitation')
      Muina::Failure(a_error).or_else { |error| invitation.puts(error) }
      expect(invitation).to have_received(:puts).with(a_error)
    end

    it do
      a_error = 1
      instance = Muina::Failure(a_error)
      expect(instance.or_else).to be(instance)
    end
  end

  describe '#error!' do
    it 'creates a failureful result with the given error' do
      error = 1
      failure = Muina::Failure(error)
      expect(failure.error!).to be(error)
    end
  end

  describe '#value!' do
    it 'creates a failed result with the given error' do
      failure = Muina::Failure(Object)
      expect { failure.value! }.to raise_error(Muina::Error)
    end
  end
end
