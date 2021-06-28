# typed: strict
# frozen_string_literal: true

SimpleCov.start do
  enable_coverage  :branch
  primary_coverage :branch

  minimum_coverage         line: 100, branch: 100
  minimum_coverage_by_file line: 90,  branch: 80

  refuse_coverage_drop :line, :branch
end
