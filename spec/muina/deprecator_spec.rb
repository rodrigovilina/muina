# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Deprecator do
  let(:old)    { 'Dummy#legacy'          }
  let(:new)    { 'Dummy#dummy'           }
  let(:logger) { instance_spy(Logger)    }

  describe '.call' do
    after { described_class.renew_instances }

    it do
      described_class.call(new: new, old: old, logger: logger)
      message = <<~M.chomp
        Method: #{old} has been DEPRECATED, please use #{new} instead
      M
      expect(logger).to have_received(:warn).with(message)
    end

    it do
      described_class.call(old: old, logger: logger)
      message = <<~M.chomp
        Method: #{old} has been DEPRECATED with no replacement
      M
      expect(logger).to have_received(:warn).with(message)
    end

    it do
      expect { described_class.call(old: old, logger: logger, raise: true) }.to raise_error(Muina::Deprecator::Error)
    end

    it do
      expect { described_class.call(old: old, raise: true) }.to raise_error(Muina::Deprecator::Error)
    end

    it do
      described_class.deactivate(old)
      expect { described_class.call(old: old, logger: logger, raise: true) }.not_to raise_error
    end

    it do
      described_class.deactivate(old)
      expect { described_class.call(old: old, logger: logger, raise: false) }.not_to raise_error
    end

    it do
      described_class.deactivate(old)
      described_class.activate(old)
      expect { described_class.call(old: old, logger: logger, raise: true) }.to raise_error(Muina::Deprecator::Error)
    end

    it do
      described_class.deactivate(old)
      described_class.activate(old)
      expect { described_class.call(old: old, logger: logger, raise: false) }.to raise_error(Muina::Deprecator::Error)
    end
  end
end
