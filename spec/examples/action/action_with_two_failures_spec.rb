# typed: false
# frozen_string_literal: true

RSpec.describe 'ActionWithTwoFailures' do
  let(:klass) do
    Class.new(Muina::Action) do
      failure { 1 }
      failure { 1 }
    end
  end

  it 'returns a result with value 1' do
    expect { klass }.to raise_error(Muina::Action::DoubleFailureError)
  end
end
