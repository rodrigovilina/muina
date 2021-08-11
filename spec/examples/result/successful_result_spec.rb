# typed: false
# frozen_string_literal: true

RSpec.describe 'SuccessfulResult' do
  subject(:success) { Muina::Success(1) }

  it do
    expect { success.value }.to raise_error(NoMethodError)
  end

  it do
    expect(success.value!).to be(1)
  end

  it do
    expect { success.error! }.to raise_error(Muina::Result::Success::ErrorCalledOnSuccessError)
  end

  it do
    hola = instance_spy(Integer, 'hola', to_s: nil)
    Muina::Success(hola).and_then(&:to_s)
    expect(hola).to have_received(:to_s)
  end

  it do
    hola = instance_spy(Integer, 'hola')
    Muina::Success(hola).or_else(&:to_s)
    expect(hola).not_to have_received(:to_s)
  end

  it do
    expect(success.and_then.or_else).to be(success)
  end
end
