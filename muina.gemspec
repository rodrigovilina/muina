# frozen_string_literal: true

require_relative 'lib/muina/version'

Gem::Specification::new do |spec|
  spec.name        = 'muina'
  spec.version     = Muina::VERSION
  spec.authors     = ['vaporyhumo']
  spec.email       = ['roanvilina@gmail.com']
  spec.license     = 'Unlicense'

  spec.summary     = 'Write safer Ruby code.'
  spec.description = 'Monads and other stuff to help you write safer Ruby code'
  spec.homepage    = 'https://github.com/vaporyhumo/muina'

  spec.files       = Dir.glob("lib/**/*.rb") + ['README.md', 'LICENSE']

  spec.required_ruby_version = Gem::Requirement::new('~> 3.1')

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['changelog_uri']   = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_development_dependency 'lollipop', '~> 0.6'
  spec.add_development_dependency 'rubocop-vaporyhumo', '~> 0.3'
end
