# require File.expand_path("../../config/initializers/setup_env", __FILE__)
require File.expand_path('../../config/db_connection', __FILE__)


# define a database schema
ActiveRecord::Schema.define do

  create_table :users, force: :cascade do |t|
    t.string :first_name
    t.string :last_name
    t.string :email
    t.datetime :created_at, null: false
    t.datetime :updated_at, null: false
  end

end

puts "ActiveRecord schema completed."
puts