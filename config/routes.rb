# Routes for application
require File.expand_path("../../app/controllers/dashboard_controller", __FILE__)
require File.expand_path("../../app/controllers/users/registration_controller", __FILE__)
require File.expand_path("../../app/controllers/users/sessions_controller", __FILE__)

set :views, File.expand_path("../../app/views", __FILE__)
set :public_folder, "./app/assets/styles"

puts File.dirname( __FILE__ )

before do
  # puts "Before filter"
  # puts "[params] = #{params}"
  # puts "app = #{app}"
  # puts "request = #{request.accept}"
  # puts "env = #{env}"
  # puts "response = #{response.body}"
  # puts "template cache = #{template_cache}"
end

# Dashboard routes
get '/' do
  @string = Dashboard.index(params)
  erb :index
end

get '/search' do
  Dashboard.search(params)
end


#User routes
get '/signup' do
  erb :new_signup
end

post '/signup' do
  User::RegistrationController.create(params)
end

get '/sign-in' do
  erb :signin
end

post '/sign-in' do
  User::SessionsController.create(params)
end




