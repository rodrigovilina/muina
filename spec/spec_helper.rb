# frozen_string_literal: true

require 'simplecov'
require 'muina'

Maybe = Muina::Maybe

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.profile_examples = 0

  Kernel.srand config.seed

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end
