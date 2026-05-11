# frozen_string_literal: true

require_relative 'lib/fat_model_auth/version'

Gem::Specification.new do |spec|
  spec.name    = 'fat_model_auth'
  spec.version = FatModelAuth::VERSION
  spec.authors = ['Brent Greeff']
  spec.email   = ['email@brentgreeff.com']

  spec.summary     = 'Resource-level Rails authorization: models declare rules, controllers enforce them.'
  spec.description = 'Models define access rules via a DSL. Controllers call auth_required. Access denied returns 404.'
  spec.homepage    = 'https://github.com/brentgreeff/fat_model_auth'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 3.3'

  spec.metadata = {
    'rubygems_mfa_required' => 'true',
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'changelog_uri' => "#{spec.homepage}/blob/main/CHANGELOG.md"
  }

  spec.files = Dir['lib/**/*', 'LICENSE.txt', 'README.md']

  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack',    '>= 7.0'
  spec.add_dependency 'activerecord',  '>= 7.0'
  spec.add_dependency 'activesupport', '>= 7.0'

  spec.add_development_dependency 'ostruct'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-rails-omakase'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'sqlite3'
end
