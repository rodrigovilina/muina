# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action::ParamsFactory do
  describe '.build' do
    context 'when given a Hash' do
      it do
        expect(described_class.build({})).to be_an(ActionController::Parameters)
      end
    end

    context 'when given something else' do
      it do
        expect(described_class.build(ActionController::Parameters.new({}))).to be_an(ActionController::Parameters)
      end
    end
  end
end
