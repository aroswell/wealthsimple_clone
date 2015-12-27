
namespace :db do
  desc "Run database schema file"
  task :schema do
    puts "Running schema ..."
    load 'lib/database_module.rb'
    Db.connect
    load 'db/schema.rb'
  end

  desc "Run seed file to populate database"
  task :seed do
    puts "Attempting to seed data..."
    load 'lib/database_module.rb'
    Db.connect
    load 'db/seed.rb'
  end

  desc "Run database creation"
  task :create do
    puts "Creating database..."
    load 'lib/database_module.rb'
    Db.create
    puts "CREATED!"
  end

  desc "Drop database"
  task :dump do
    puts "Dropping database..."
    load 'lib/database_module.rb'
    Db.dump
    puts "DROPPED!"
  end

  desc "Create and setup database - run create_db, schema and seed"
  task setup: [:create, :schema, :seed]


  desc "Reset database complete"
  task reset: [:dump, :create, :schema, :seed]

end

namespace :app do
  desc "Setup application environment variables"
  task :setup do
    puts "Setting application required environment variables"
    ruby "config/initializers/setup_env.rb"
    puts "ENV appended"
  end

end