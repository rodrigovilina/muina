# typed: false
# frozen_string_literal: true

RSpec.describe Muina do
  it 'has a version number' do
    expect(Muina::VERSION).not_to be nil
  end

  describe '.Success' do
    it do
      check_value_or_error(1, :Success, :value!)
    end
  end

  describe '.Failure' do
    it do
      check_value_or_error(1, :Failure, :error!)
    end
  end

  describe '.Result' do
    it 'success', aggregate_failures: true do
      value = 1
      result = described_class.Result { value }
      expect(result).to be_a(Muina::Result::Success)
      expect(result.value!).to be(value)
    end

    it 'fail', aggregate_failures: true do
      error = StandardError
      result = described_class.Result { raise error }
      expect(result).to be_a(Muina::Result::Failure)
      expect(result.error!).to be_a(error)
    end
  end

  def check_value_or_error(value_or_error, klass, method)
    expect(described_class.__send__(klass, value_or_error).__send__(method)).to be(value_or_error)
  end
end
