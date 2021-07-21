# typed: strict
# frozen_string_literal: true

require 'simplecov' unless $PROGRAM_NAME == 'bin/mutant'
require 'muina'
require 'byebug'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

require 'rspec/mocks'

module RSpec
  module Mocks
    class InstanceVerifyingDouble
      sig { params(expected: T.untyped).returns(T.untyped) }
      def is_a?(expected)
        @doubled_module = T.let(@doubled_module, T.untyped)
        @doubled_module.target <= expected || super
      end
    end
  end
end

# require 'sorbet-runtime'
#
# RSpec.configure do |config|
#   config.before do
#     T::Configuration.inline_type_error_handler = proc do |error|
#       unless error.message.include?('RSpec::Mocks') ||
#         error.message.include?('InstanceDouble') ||
#         error.message.include?(' with hash ')
#         raise(error)
#       end
#     end
#
#     T::Configuration.call_validation_error_handler = proc do |_signature, opts|
#       unless opts[:message].include?('RSpec::Mocks') ||
#         opts[:message].include?('InstanceDouble') ||
#         opts[:message].include?(' with hash ')
#         raise(TypeError, opts[:pretty_message])
#       end
#     end
#   end
#
#   config.after do
#     T::Configuration.inline_type_error_handler = nil
#     T::Configuration.call_validation_error_handler = nil
#   end
# end
