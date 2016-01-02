# Routes file for application

require File.expand_path("../../app/controllers/application_controller", __FILE__)
require File.expand_path("../../app/controllers/dashboard_controller", __FILE__)
require File.expand_path("../../app/controllers/users/registration_controller", __FILE__)
require File.expand_path("../../app/controllers/users/sessions_controller", __FILE__)
require File.expand_path("../../app/controllers/forms_controller", __FILE__)



configure do
  # set :run, false
  set :server, %w[thin mongrel webrick] # this is the default
  set :views, File.expand_path("../../app/views", __FILE__)
  set :public_folder, "./app/assets/styles"
  enable :sessions
  set :session_secret, ENV["SECRET_TOKEN"]
end


before do
  # puts "Before filter"
  puts "[params] = #{params}"
  # puts "app = #{app}"
  puts "Path info = #{request.path_info}"
  print "#{session.keys}" + "\n"
  puts session[:session_id]
  puts session[:csrf]
  puts session[:tracking]
  puts "\n"

  # puts "env = #{env}"
  # puts "response = #{response.body}"
  # puts "template cache = #{template_cache}"
end


# DashboardController routes
get '/' do
  erb :"dashboard/index"
end

get '/onboarding' do
  # If visitor is not signed in, then redirect to sign-in page
  if current_user
    erb :"dashboard/onboarding"
  else
    redirect to '/sign-in'
  end
end

get '/search' do
  Dashboard.search(params)
end


# UserController routes
get '/signup' do
  erb :"registrations/new_signup"
end

post '/signup' do
  user = UserController::RegistrationController.create(params)
  session[:user_id] = user.id unless user.nil?
  redirect to('/onboarding')
end

get '/sign-in' do
  erb :"sessions/signin"
end

post '/sign-in' do
  UserController::SessionsController.create(params)
end


# FormController routes for KYC form
get '/application/new' do
  # call the new method in form_controller
  Forms::KycController.new

  erb :"forms/kyc/new"
end

get '/application/edit' do
  # call the edit method in form_controller
  Forms::KycController.edit

  erb :"forms/kyc/new"
end

post '/application/create' do
  # call the create method in form_controller
  Forms::KycController.create

  "Need to redirect somewhere"
end

post '/application/update' do
  # call the update method in form_controller
  Forms::KycController.update

  "Need to redirect somewhere"
end

# FormController routes for risk form
get '/risk_assessment/new' do
  # call the new method in form_controller
  Forms::RiskAssessmentController.new

  erb :"forms/risk_assessment/new"
end

get '/risk_assessment/edit' do
  # call the edit method in form_controller
  Forms::RiskAssessmentController.edit

  erb :"forms/risk_assessment/new"
end

post '/risk_assessment/create' do
  # call the create method in form_controller
  Forms::RiskAssessmentController.create

  "Need to redirect somewhere"
end

post '/risk_assessment/update' do
  # call the update method in form_controller
  Forms::RiskAssessmentController.update

  "Need to redirect somewhere"
end

# FormController routes for form sign off
get '/sign-forms/new' do
  # call the new method in form_controller
  Forms::SignFormsController.new

  erb :"forms/sign_forms/new"
end

post '/sign-forms/create' do
  # call the new method in form_controller
  Forms::SignFormsController.create

  "Need to redirect somewhere"
end


# helper methods: method will be available to routing method blocks and to the views
helpers do
  def current_user
    App.current_user(session)
  end
end








