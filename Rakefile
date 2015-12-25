
namespace :db do
  desc "Run database schema file"
  task :schema do
    puts "Running schema ..."
    ruby 'db/schema.rb'
  end

  desc "Run seed file to populate database"
  task :seed do
    puts "Attempting to seed data..."
    ruby 'db/seed.rb'
  end

  desc "Run database creation"
  task :create do
    puts "Creating database..."
    ruby "db/create_db.rb"
  end

  desc "Create and setup database - run create_db, schema and seed"
  task setup: [:create, :schema, :seed] do
    puts "Attempting to setup database and seed data..."
    puts "Setup complete"
  end

  desc "Reset database complete"
  task reset: [:dump, :create, :schema, :seed] do
  end

end

namespace :app do
  desc "Setup application environment variables"
  task :setup do
    puts "Setting application required environment variables"
    ruby "config/initializers/setup_env.rb"
    puts "ENV appended"
  end

end