# typed: false
# frozen_string_literal: true

RSpec.describe 'FailedResult' do
  subject(:failure) { Muina::Failure(1) }

  it do
    expect { failure.error }.to raise_error(NoMethodError)
  end

  it do
    expect(failure.error!).to be(1)
  end

  it do
    expect { failure.value! }.to raise_error(Muina::Result::Failure::ValueCalledOnFailureError)
  end

  it do
    hola = instance_spy(Integer, 'hola', to_s: nil)
    Muina::Failure(hola).or_else(&:to_s)
    expect(hola).to have_received(:to_s)
  end

  it do
    hola = instance_spy(Integer, 'hola', to_s: nil)
    Muina::Failure(hola).and_then(&:to_s)
    expect(hola).not_to have_received(:to_s)
  end

  it do
    expect(failure.and_then.or_else).to be(failure)
  end
end
