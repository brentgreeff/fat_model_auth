Gem::Specification.new do |s|
  s.name = %q{fat_model_auth}
  s.version = "3.0.0"
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brent Greeff"]
  s.date = %q{2010-10-30}
  s.description = %q{Clean resource based Authorisation plugin for Rails.}
  s.email = %q{email@brentgreeff.com}
  s.extra_rdoc_files = [
    "MIT-LICENSE",
    "README.rdoc"
  ]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n");
  s.homepage = %q{http://github.com/brentgreeff/fat_model_auth}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Clean resource based Authorisation plugin for Rails.}

  s.add_development_dependency('minitest', '~> 4.2')

  s.add_dependency('activesupport', '>= 3.0.0')
  s.add_dependency('actionpack',    '>= 3.0.0')
end
