
namespace :db do
  desc "Run database schema file"
  task :schema do
    puts "Running schema ..."
    load 'lib/database_module.rb'
    pool = Database::Pool.new
    pool.connect
    load 'db/schema.rb'
    pool.release
  end

  desc "Run seed file to populate database"
  task :seed do
    puts "Attempting to seed data..."
    load 'lib/database_module.rb'
    pool = Database::Pool.new
    pool.connect
    load 'db/seed.rb'
    pool.release
  end

  desc "Run database creation"
  task :create do
    puts "Creating database..."
    load 'lib/database_module.rb'
    Database::Setup.create
    puts "CREATED!"
  end

  desc "Drop database"
  task :dump do
    puts "Dropping database..."
    load 'lib/database_module.rb'
    Database::Setup.dump
    puts "DROPPED!"
  end

  desc "Create and setup database"
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

  desc "Run application"
  task :run, [:env] do |t, args|
    args.with_defaults( env: "development")
    ENV["APP_ENVIRONMENT"] = "#{args[:env]}"
    sh "rerun bin/server.rb"
  end

end










