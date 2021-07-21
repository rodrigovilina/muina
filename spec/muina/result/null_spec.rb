# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Result::Null do
  shared_examples 'dont run block on side and return self' do |method|
    it do
      invitation = instance_spy(IO, 'invitation')
      described_class.__send__(:new).__send__(method) { |value| invitation.puts(value) }
      expect(invitation).not_to have_received(:puts)
    end

    it do
      instance = described_class.__send__(:new)
      expect(instance.__send__(method)).to be(instance)
    end
  end

  shared_examples 'raise on side' do |method|
    it do
      null = described_class.__send__(:new)
      expect { null.__send__(method) }.to raise_error(Muina::Error)
    end
  end

  it_behaves_like 'dont run block on side and return self', :and_then
  it_behaves_like 'dont run block on side and return self', :or_else

  it_behaves_like 'raise on side', :value!
  it_behaves_like 'raise on side', :error!
end
