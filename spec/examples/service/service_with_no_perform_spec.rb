# typed: false
# frozen_string_literal: true

ServiceWithNoPerform = Object

RSpec.describe 'ServiceWithNoPerform' do
  it do
    expect do
      stub_const('ServiceWithNoPerform', Class.new(Muina::Service))
      ServiceWithNoPerform.call
    end.to raise_error(NotImplementedError, 'Please implement the ServiceWithNoPerform#perform method')
  end
end
