begin
  require 'bundler/setup'
  require 'bundler/gem_tasks'
rescue LoadError
  raise 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

desc 'Default: run unit tests.'

require 'rake/testtask'

desc 'Test the fat_model_auth plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

require 'rdoc/task'

desc 'Generate documentation for the fat_model_auth plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'FatModelAuth'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task default: :test
