# Seed file for populating the database
require File.expand_path( "../../app/models/user", __FILE__ )


User.delete_all

# Seed data
3.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password'
    )
end

puts "Seeding complete!"