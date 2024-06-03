# typed: strict
# frozen_string_literal: true

guard :rspec, cmd: 'bin/rspec' do # rubocop:disable Metrics/BlockLength
  require 'guard/rspec/dsl'

  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
end

guard :rubocop do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end

# guard(:shell) { watch(/(.*)_spec.rb/) { `mutant run --fail-fast` } }
