# Routes for application
require File.expand_path("../../app/controllers/dashboard_controller", __FILE__)
require File.expand_path("../../app/controllers/users/registration_controller", __FILE__)
require File.expand_path("../../app/controllers/users/sessions_controller", __FILE__)


current_user = false

configure do
  set :views, File.expand_path("../../app/views", __FILE__)
  set :public_folder, "./app/assets/styles"
  enable :sessions
end

before do
  # puts "Before filter"
  # puts "[params] = #{params}"
  # puts "app = #{app}"
  puts "Path info = #{request.path_info}"
  puts session
  # puts "env = #{env}"
  # puts "response = #{response.body}"
  # puts "template cache = #{template_cache}"
end

# DashboardController routes
get '/' do
  erb :index
end

get '/onboarding' do
  # If visitor is not signed in, then redirect to sign-in page
  if current_user
    erb :onboarding
  else
    redirect to '/sign-in'
  end
end

get '/search' do
  Dashboard.search(params)
end


# UserController routes
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





