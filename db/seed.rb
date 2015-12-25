require File.expand_path('../../config/db_connection', __FILE__)
require "faker"

class User < ActiveRecord::Base
end

User.delete_all

# Seed data
3.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    )
end

puts "Seeding complete!"