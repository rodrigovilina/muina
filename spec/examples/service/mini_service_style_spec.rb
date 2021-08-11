# typed: false
# frozen_string_literal: true

AddOne = Object

RSpec.describe 'MiniService' do
  let(:mini_service) do
    Class.new(Muina::Service) do
      arguments :a, b: 1

      def perform
        a + b
      end
    end
  end

  it do
    stub_const('AddOne', mini_service)
    expect(AddOne.call(a: 1)).to be(2)
  end
end
