require File.expand_path( '../../config/boot', __FILE__)
require 'yaml'
require 'erb'
require 'singleton'



module Database

  puts "Database module loaded"

  # convert yml file to erb template to read in variables
  # read in the new yml content and create a hash

  def self.yaml_file_path
    File.expand_path( '../../config/database.yml', __FILE__ )
  end

  def self.render_template(yaml_string)
    template = ERB.new(yaml_string)
    template.result(binding)
  end


  def self.default_config
    yml_file = File.open(yaml_file_path, "r")
    config = YAML.load( render_template(yml_file.read) )
    yml_file.close

    return config
  end


  class Setup
    def self.create
      conn = PG.connect(dbname: 'postgres')
      conn.exec("CREATE DATABASE #{ENV["DB_NAME"]} WITH OWNER #{ENV["DB_USERNAME"]}")
      conn.exec("ALTER USER #{ENV["DB_USERNAME"]} WITH PASSWORD '#{ENV["DB_PASSWORD"]}'")
    end

    def self.dump
      conn = PG.connect(dbname: 'postgres')
      conn.exec("DROP DATABASE #{ENV["DB_NAME"]}")
    end
  end


  class Pool
    include Singleton
    attr_reader :db_config, :logfile_path, :the_connection_pool

    def initialize( config_hash = Database.default_config, logfile_path = File.expand_path('../../db/database.log', __FILE__) )
      @db_config = config_hash
      @logfile_path = logfile_path
      @the_connection_pool = ActiveRecord::Base.establish_connection(@db_config)
    end

    def connect
      @the_connection = @the_connection_pool.connection
      logger = Logger.new(File.open(@logfile_path, "w"))
      logger.level = Logger::DEBUG
      ActiveRecord::Base.logger = logger

      return @the_connection
    end

    def release
      @the_connection_pool.checkin(@the_connection)
    end

    def disconnect_all
      @the_connection_pool.disconnect! if @the_connection_pool
    end
  end

end


