# typed: false
# frozen_string_literal: true

RSpec.describe 'ErrorOnQuery' do
  let(:action) do
    hola = instance_spy(Integer, to_s: nil)
    Class.new(Muina::Action) do
      parameters { const :a, Integer }

      query(:b) { raise NoMethodError }
      command { hola.to_s }

      result do
        a + b
      end
    end
  end

  it do
    expect(action.call(a: 1).error!).to be_a(NoMethodError)
  end
end
