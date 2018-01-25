lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fat_model_auth/version"

Gem::Specification.new do |spec|
  spec.name = "fat_model_auth"
  spec.version = FatModelAuth::VERSION
  spec.authors = ["Brent Greeff"]
  spec.email = ["email@brentgreeff.com"]

  spec.summary = %q{Clean resource based Authorisation system for Rails.}
  spec.description = %q{Define the rules for accessing resources through a simple DSL.}
  spec.homepage = "https://github.com/brentgreeff/fat_model_auth"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activesupport", "~> 5.1"
  spec.add_development_dependency "activerecord", "~> 5.1"
  spec.add_development_dependency "actionpack", "~> 5.1"
  spec.add_development_dependency "sqlite3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "guard-rspec"
  # spec.add_development_dependency "cucumber"
  # spec.add_development_dependency "aruba"
  spec.add_development_dependency "awesome_print"
end
