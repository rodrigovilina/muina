# typed: strict
# frozen_string_literal: true

require_relative 'lib/muina/version'

Gem::Specification.new do |spec|
  spec.name          = 'muina'
  spec.version       = Muina::VERSION
  spec.authors       = ['vaporyhumo']
  spec.email         = ['roanvilina@gmail.com']

  spec.summary       = 'Rails and Sorbet compatible framework'
  spec.description   = 'Useful parent classes for the Rails missing parts'
  spec.homepage      = 'https://github.com/vaporyhumo/muina'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri']   = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = ['muina']
  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack'
  spec.add_dependency 'sorbet-rails'
  spec.add_dependency 'sorbet-runtime'
  spec.add_dependency 'sorbet-struct-comparable'
  spec.add_dependency 'zeitwerk'
end
