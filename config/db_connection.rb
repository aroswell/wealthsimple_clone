# require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require "logger"
require_relative "initializers/setup_env.rb"

# require "yaml"
# yaml_file_path = File.expand_path('../../config/database.yml', __FILE__)
# data_base_configuration = YAML::load( File.open(yaml_file_path) )
# puts data_base_configuration
# puts $LOAD_PATH

logfile_path = File.expand_path('../../db/database.log', __FILE__)

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