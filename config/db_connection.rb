require "active_record"
# require "yaml"
require "logger"
require_relative "initializers/setup_env.rb"

# yaml_file_path = File.expand_path('../../config/database.yml', __FILE__)
logfile_path = File.expand_path('../../db/database.log', __FILE__)

# data_base_configuration = YAML::load( File.open(yaml_file_path) )
# puts data_base_configuration

db_config = {
  adapter: 'postgresql',
  database: ENV["DB_NAME_DEV"],
  username: ENV["DB_USERNAME"],
  password: ENV["DB_PASSWORD"],
  host: 'localhost',
  encoding: 'utf8',
  pool: 5
}

ActiveRecord::Base.establish_connection(db_config)
ActiveRecord::Base.logger = Logger.new(File.open(logfile_path, "w"))