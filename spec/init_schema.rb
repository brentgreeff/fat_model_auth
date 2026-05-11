# frozen_string_literal: true

require 'yaml'

database_yml = File.expand_path('database.yml', __dir__)
config = YAML.safe_load_file(database_yml)
ActiveRecord::Base.establish_connection(config['test'])

load File.expand_path('schema.rb', __dir__)
