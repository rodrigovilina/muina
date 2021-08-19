# typed: false
# frozen_string_literal: true

RSpec.describe 'TypicalAction' do
  let(:a_spy) { instance_spy(String, to_s: nil) }
  let(:klass) do
    the_spy = a_spy
    Class.new(Muina::Action) do
      parameters do
        const :a, Integer
      end

      query(:b) { 1 }
      command { the_spy.to_s }

      result do
        a + b
      end
    end
  end

  it '', aggregate_failures: true do
    expect(klass.call(a: 1).value!).to be(2)
    expect(a_spy).to have_received(:to_s)
  end
end
