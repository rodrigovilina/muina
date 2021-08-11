# typed: false
# frozen_string_literal: true

RSpec.describe 'NullResult' do
  subject(:null_result) { Muina::Result::Null() }

  it do
    expect { null_result.value! }.to raise_error(Muina::Error)
  end

  it do
    expect { null_result.error! }.to raise_error(Muina::Error)
  end

  it do
    hola = instance_spy(Integer, 'hola')
    null_result.and_then { hola.to_s }
    expect(hola).not_to have_received(:to_s)
  end

  it do
    hola = instance_spy(Integer, 'hola')
    null_result.or_else { hola.to_s }
    expect(hola).not_to have_received(:to_s)
  end
end
