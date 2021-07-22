# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action do
  describe '.call' do
    let(:klass) do
      Class.new(described_class) do
        parameters do
          const :a, IO
          const :b, IO
        end

        result do
          a.puts
          1
        end

        failure { b.puts }
      end
    end
    let(:io_a) { instance_double(IO) }
    let(:io_b) { instance_double(IO) }

    before do
      allow(io_a).to receive(:puts)
      allow(io_b).to receive(:puts)
    end

    it '', aggregate_failures: true do
      result = klass.call(a: io_a, b: io_b)
      expect(io_a).to have_received(:puts)
      expect(io_b).not_to have_received(:puts)
      expect(result.value!).to be(1)
    end

    context 'when given no params' do
      let(:klass) do
        Class.new(described_class)
      end

      it do
        expect(klass.call).to be_a(Muina::Result)
      end
    end
  end
end
