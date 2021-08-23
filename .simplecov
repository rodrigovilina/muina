# frozen_string_literal: true

SimpleCov.start do # rubocop:disable Metrics/BlockLength
  enable_coverage  :branch
  primary_coverage :branch

  minimum_coverage         line: 100, branch: 100
  minimum_coverage_by_file line: 100, branch: 100

  refuse_coverage_drop :line, :branch

  add_filter '/spec/'
end
