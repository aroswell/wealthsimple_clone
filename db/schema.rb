# define a database schema

ActiveRecord::Schema.define do

  create_table :users, force: :cascade do |t|
    t.string :first_name
    t.string :last_name
    t.string :email
    t.string :password_digest
    t.datetime :created_at, null: false
    t.datetime :updated_at, null: false
  end

end

puts "ActiveRecord schema completed."
puts