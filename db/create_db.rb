require File.expand_path("../../config/initializers/setup_env", __FILE__)
require 'pg'

conn = PG.connect(dbname: 'postgres')
conn.exec("CREATE DATABASE #{ENV["DB_NAME_DEV"]} WITH OWNER #{ENV["DB_USERNAME"]}")
conn.exec("ALTER USER #{ENV["DB_USERNAME"]} WITH PASSWORD '#{ENV["DB_PASSWORD"]}'")
