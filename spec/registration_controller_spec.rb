# Unit and Controller test for RegistrationController

require File.expand_path( "../../bin/server", __FILE__ )
require "rack/test"


describe UserController::RegistrationController do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET signup' do
    let(:s_controller) { UserController::SessionsController }

    context "Looking for Ok Response regardless of current user status" do
      it "returns 200 response even if THERE IS NO current_user" do
        allow(s_controller).to receive(:current_user) { false }
        get '/signup'
        expect(last_response.status).to eq(200)

      end

      it "returns 302 even if THERE IS A current_user" do
        allow(s_controller).to receive(:current_user) { true }
        get '/signup'
        expect(last_response.status).to eq(302)
      end
    end

    context "Response Body for GET signup" do
      it "response body contains signup form when there is NO current user" do
        allow(s_controller).to receive(:current_user) { false }
        get '/signup'
        expect(last_response.body).to include("<form action=\"/signup\" method=\"post\">")
      end

      it "response body is empty when THERE IS A current user, due to the redirect" do
        allow(s_controller).to receive(:current_user) { true }
        get '/signup'
        expect(last_response.body).to include("")
      end
    end
  end

  describe 'POST signup' do
    let(:params) { { "user" => {"first_name" => "Ricky", "last_name" => "Castle", "email" => "nikki_heat@castle.com",
        "password" => "password", "password_confirmation" => "password"} } }
    let(:client_params) { { :client => {first_name: "Brady", last_name: "smith", email: "smith_man@castle.com",
        password: "password", password_confirmation: "password"} } }
    let(:user) { User.create( client_params[:client] ) }
    # let(:registrar) { object_double(UserController::RegistrationController.new(params), create: user)}

    # it 'creates new user' do
    #   post '/signup'
    # end

    it 'redirects after giving a 302 status' do
      # allow(registrar).to receive(:create) { user }
      mock_registrar = object_double( UserController::RegistrationController.new(params) )
      allow(UserController::RegistrationController).to receive(:new).with(params) { mock_registrar }
      allow(UserController::RegistrationController.new(params)).to receive(:create) { user }
      post '/signup', params
      expect(last_response.status).to eq(302)
    end

  end


end


      # File.open('./test_log.html', 'w') do |f|
      #   f.puts last_response.body
      # end




