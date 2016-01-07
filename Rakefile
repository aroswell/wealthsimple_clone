
namespace :db do
  desc "Loading database module"
  task :db_module, [:env] do |t, args|
    args.with_defaults( env: "development")
    ENV["APP_ENVIRONMENT"] = "#{args[:env]}"
    load 'lib/database_module.rb'
  end

  desc "Run database schema file"
  task :schema => [:db_module] do
    puts "Running schema ..."
    pool = Database::Pool.instance
    pool.connect
    load 'db/schema.rb'
    pool.release
  end

  desc "Run seed file to populate database"
  task :seed, [:env] => [:db_module] do |t, args|
    args.with_defaults( env: "development")
    if args[:env] == "development"
      puts "Attempting to seed data..."
      pool = Database::Pool.instance
      pool.connect
      load 'db/seed.rb'
      pool.release
    elsif args[:env] == "test"
      puts "Not seed data availabe for test database"
    end

  end

  desc "Run database creation"
  task :create, [:env] => [:db_module] do
    puts "Creating database..."
    Database::Setup.create
    puts "CREATED!"
  end

  desc "Drop database"
  task :dump, [:env] => [:db_module] do
    puts "Dropping database..."
    Database::Setup.dump
    puts "DROPPED!"
  end

  desc "Create and setup database"
  task :setup, [:env] => [:create, :schema, :seed]

  desc "Reset database complete"
  task :reset, [:env] => [:dump, :create, :schema, :seed]

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


# desc "this is a test"
# task :go, [:env] do |t, args|
#   args.with_defaults( env: "development")
#   ENV["APP_ENVIRONMENT"] = "#{args[:env]}"
#   Rake::Task["dump"].execute
#   Rake::Task["create"].execute
#   Rake::Task["schema"].execute
#   Rake::Task["seed"].execute
#    # [:dump, :create, :schema, :seed]
# end













