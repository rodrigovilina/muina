# typed: false
# frozen_string_literal: true

RSpec.describe 'ActionWithTwoFailures' do
  let(:a_spy) { instance_spy(String) }
  let(:klass) do
    the_spy = a_spy
    Class.new(Muina::Action) do
      query(:hola) { raise StandardError, 'hola' }
      query(:chao) { the_spy.to_s }
    end
  end

  it 'returns a result with value 1', aggregate_failures: true do
    result = klass.call
    expect(a_spy).not_to have_received(:to_s)
    expect(result).to be_a(Muina::Result::Failure)
  end
end
