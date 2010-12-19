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
  s.files = [
    "MIT-LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/fat_model_auth.rb",
    "lib/fat_model_auth/canned_gate_keeper.rb",
    "lib/fat_model_auth/controller_helpers.rb",
    "lib/fat_model_auth/gate_keeper.rb",
    "lib/fat_model_auth/model_helpers.rb",
    "lib/fat_model_auth/view_helpers.rb",
    "test/fat_model_auth_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/brentgreeff/fat_model_auth}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Clean resource based Authorisation plugin for Rails.}
end
