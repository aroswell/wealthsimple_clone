require File.expand_path("../../config/initializers/setup_env", __FILE__)
require 'pg'

conn = PG.connect(dbname: 'postgres')
conn.exec("DROP DATABASE #{ENV["DB_NAME_DEV"]}")
