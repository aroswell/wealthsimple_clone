# Routes file for application

require File.expand_path("../../lib/database_module", __FILE__ )
require File.expand_path("../../helpers/helpers", __FILE__)
require File.expand_path("../../app/models/user", __FILE__)
require File.expand_path("../../app/controllers/application_controller", __FILE__)
require File.expand_path("../../app/controllers/dashboard_controller", __FILE__)
require File.expand_path("../../app/controllers/users/registration_controller", __FILE__)
require File.expand_path("../../app/controllers/users/sessions_controller", __FILE__)
require File.expand_path("../../app/controllers/forms_controller", __FILE__)

def pool
  Database::Pool.instance
end

configure do
  set :server, %w[thin mongrel webrick] # this is the default
  set :views, File.expand_path("../../app/views", __FILE__)
  set :public_folder, "./app/assets/styles"
  enable :sessions
  set :session_secret, ENV["SECRET_TOKEN"]
end

# Variables available from Sinatra:
# params, app, request, env, response, template_cache


before do
  pool.connect
  @current_user = RoutingHelper.current_user(session)
end

after do
  pool.release
end

# DashboardController routes
    get '/' do
      if @current_user && @current_user.approved?
        erb :"dashboard/index"
      elsif @current_user
        redirect to('/onboarding')
      else
        redirect to '/sign-in'
      end
    end

    get '/onboarding' do
      # If visitor is not signed in, then redirect to sign-in page
      if @current_user
        erb :"dashboard/onboarding"
      else
        redirect to '/'
      end
    end


# UserController routes
    get '/signup' do
      unless @current_user
        erb :"registrations/new_signup"
      else
        redirect to '/'
      end
    end

    post '/signup' do
      user = RoutingHelper.create_user
      session[:user_id] = user.id unless user.nil?
      redirect to('/')
    end

    get '/sign-in' do
      unless @current_user
        erb :"sessions/signin"
      else
        redirect to '/'
      end
    end

    post '/sign-in' do
      user = RoutingHelper.fetch_user
      RoutingHelper.create_user_session(session, user)
      redirect to('/')
    end

    delete '/logout' do
      RoutingHelper.delete_user_session(session)
      redirect to('/')
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
  class RoutingHelper
    def self.current_user(session)
      UserController::SessionsController.new.current_user(session)
    end

    def self.create_user_session(session, user)
      UserController::SessionsController.new.create(session, user)
    end

    def self.delete_user_session(session)
      UserController::SessionsController.new.delete(session)
    end

    def self.create_user
      UserController::RegistrationController.new(params).create
    end

    def self.fetch_user
      UserController::RegistrationController.new(params).fetch
    end
  end

end








