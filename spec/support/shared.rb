# typed: false
# frozen_string_literal: true

RSpec.shared_examples 'matching side' do |method, klass|
  it do
    a_value = 1
    invitation = instance_spy(IO, 'invitation')
    Muina.__send__(klass, a_value).__send__(method) { |value| invitation.puts(value) }
    expect(invitation).to have_received(:puts).with(a_value)
  end

  it do
    a_value = 1
    instance = Muina.__send__(klass, a_value)
    expect(instance.__send__(method)).to be(instance)
  end
end

RSpec.shared_examples 'unmatching side' do |method, klass|
  it do
    invitation = instance_spy(IO, 'invitation')
    Muina.__send__(klass, :Object).__send__(method) { |error| invitation.puts(error) }
    expect(invitation).not_to have_received(:puts)
  end

  it do
    instance = Muina.__send__(klass, Object)
    expect(instance.__send__(method)).to be(instance)
  end
end

RSpec.shared_examples 'matching unwrap' do |unwrap, klass|
  it 'creates a successful result with the given value' do
    value = 1
    success = Muina.__send__(klass, value)
    expect(success.__send__(unwrap)).to be(value)
  end
end

RSpec.shared_examples 'unmatching unwrap' do |unwrap, klass|
  it 'creates a failed result with the given error' do
    success = Muina.__send__(klass, Object)
    expect { success.__send__(unwrap) }.to raise_error(Muina::Error)
  end
end

# rubocop:disable Metrics/ParameterLists
RSpec.shared_examples 'acts as result' do |klass, matching_block, unmatching_block, matching_unwrap, unmatching_unwrap|
  describe '#and_then' do
    it_behaves_like 'matching side', matching_block, klass
  end

  describe '#or_else' do
    it_behaves_like 'unmatching side', unmatching_block, klass
  end

  describe '#value!' do
    it_behaves_like 'matching unwrap', matching_unwrap, klass
  end

  describe '#error!' do
    it_behaves_like 'unmatching unwrap', unmatching_unwrap, klass
  end
end
# rubocop:enable Metrics/ParameterLists
