# typed: false
# frozen_string_literal: true

RSpec.describe 'TypicalAction' do
  it do
    hola = instance_spy(Integer, to_s: nil)
    expect(
      Class.new(Muina::Action) do
        parameters do
          const :a, Integer
        end

        query(:b) { 1 }
        command { hola.to_s }

        result do
          a + b
        end
      end.call(a: 1).value!
    ).to be(2)
    expect(hola).to have_received(:to_s)
  end
end
