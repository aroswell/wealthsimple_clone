require File.expand_path( '../../config/boot', __FILE__)

module Db

  @db_config = {
    adapter: 'postgresql',
    database: ENV["DB_NAME_DEV"],
    username: ENV["DB_USERNAME"],
    password: ENV["DB_PASSWORD"],
    host: 'localhost',
    encoding: 'utf8',
    pool: 5
  }

  def self.create
    conn = PG.connect(dbname: 'postgres')
    conn.exec("CREATE DATABASE #{ENV["DB_NAME_DEV"]} WITH OWNER #{ENV["DB_USERNAME"]}")
    conn.exec("ALTER USER #{ENV["DB_USERNAME"]} WITH PASSWORD '#{ENV["DB_PASSWORD"]}'")
  end

  def self.dump
    conn = PG.connect(dbname: 'postgres')
    conn.exec("DROP DATABASE #{ENV["DB_NAME_DEV"]}")
  end

  def self.connect
    logfile_path = File.expand_path('../../db/database.log', __FILE__)
    ActiveRecord::Base.establish_connection(@db_config)
    logger = Logger.new(File.open(logfile_path, "w"))
    logger.level = Logger::DEBUG
    ActiveRecord::Base.logger = logger
  end

  # module_function :connect

end