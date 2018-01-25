# log_path = File.join(CurrentDir, "debug.log")
# ActiveRecord::Base.logger = Logger.new(log_path)

def load_db_config
  database_yml = File.expand_path('../database.yml', __FILE__)
  config = YAML::load( IO.read(database_yml) )
  config['test']
end

ActiveRecord::Base.establish_connection( load_db_config )
load( File.expand_path('../schema.rb', __FILE__) )
