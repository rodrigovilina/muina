# typed: false
# frozen_string_literal: true

RSpec.describe 'ActionWithTwoResults' do
  let(:klass) do
    Class.new(Muina::Action) do
      result { 1 }
      result { 1 }
    end
  end

  it 'returns a result with value 1' do
    expect { klass }.to raise_error(Muina::Action::DoubleResultError)
  end
end
