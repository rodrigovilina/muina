# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action do
  describe '.result' do
    let(:one) do
      Class.new(described_class) do
        result { 1 }
      end
    end
    let(:standard_error) do
      Class.new(described_class) do
        result { raise StandardError }
      end
    end
    let(:muina_error) do
      Class.new(described_class) do
        @failure = KeyError

        result { raise Muina::Error }
      end
    end
    let(:two_error) do
      Class.new(described_class) do
        @failure = [KeyError, NoMethodError]

        result { raise Muina::Error }
      end
    end
    let(:mismatch) do
      Class.new(described_class) do
        @success = Integer

        result { 1.0 }
      end
    end

    it '1', aggregate_failures: true do
      result = one.call
      expect(result).to be_an(M::Result)
      expect(result.value).to be(1)
      expect { result.error }.to raise_error(Muina::Error)
    end

    it '2', aggregate_failures: true do
      result = standard_error.call
      expect(result).to be_an(M::Result)
      expect { result.value }.to raise_error(Muina::Error)
      expect(result.error).to be_an(StandardError)
    end

    it '3', aggregate_failures: true do
      expect { muina_error.call }.to raise_error(Muina::Error)
    end

    it '4', aggregate_failures: true do
      expect { two_error.call }.to raise_error(Muina::Error)
    end

    it '5' do
      expect { mismatch.call }.to raise_error(TypeError)
    end
  end

  # describe '.steps' do
  #   xit do
  #     expect do
  #       Class.new(described_class) do
  #         @steps = {}
  #       end.steps
  #     end.to raise_error(TypeError)
  #   end
  # end
end
