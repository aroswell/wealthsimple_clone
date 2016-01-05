require File.expand_path( '../../config/boot', __FILE__)

module Db
  puts "Database module loaded"

  @db_config = {
    adapter: 'postgresql',
    database: ENV["DB_NAME_DEV"],
    username: ENV["DB_USERNAME"],
    password: ENV["DB_PASSWORD"],
    host: 'localhost',
    encoding: 'utf8',
    pool: 5
    # timeout: 7000
  }

  @logfile_path = File.expand_path('../../db/database.log', __FILE__)

  @the_connection_pool = ActiveRecord::Base.establish_connection(@db_config)
  puts @the_connection_pool.class


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
    # the_connection = ActiveRecord::Base.establish_connection(@db_config)
    puts "Are there any connections to the database: #{@the_connection_pool.connected?}"
    puts "How many connections are there: #{@the_connection_pool.connections.length}"

    @the_connection = @the_connection_pool.connection
    puts "Here's the connection object: #{@the_connection}"

    logger = Logger.new(File.open(@logfile_path, "w"))
    logger.level = Logger::DEBUG
    ActiveRecord::Base.logger = logger

    return @the_connection
  end

  def self.release
    @the_connection_pool.checkin(@the_connection)
    puts "How many connections are there after release: #{@the_connection_pool.connections.length}"

  end

  def self.disconnect_all
    @the_connection_pool.disconnect! if @the_connection_pool
  end


  # module_function :connect

end