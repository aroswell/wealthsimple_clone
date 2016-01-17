# Unit and Controller test for RegistrationController

require File.expand_path( "../../bin/server", __FILE__ )
require "rack/test"


describe UserController::RegistrationController do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET signup' do
    let(:routing_helper) { RoutingHelper }

    context "Http responses depending on current user status" do
      it "returns 200 response even if THERE IS NO current_user" do
        allow(routing_helper).to receive(:current_user) { false }
        get '/signup'
        expect(last_response.status).to eq(200)

      end

      it "returns 302 if THERE IS A current_user" do
        allow(routing_helper).to receive(:current_user) { true }
        get '/signup'
        expect(last_response.status).to eq(302)
      end

      it 'redirect to "/sign-in" if current_user == true' do
        allow(routing_helper).to receive(:current_user) { true }
        get '/signup'
        expect(last_response.redirect?).to be(true)
        follow_redirect!
        expect(last_request.path).to eq('/')
      end
    end

    context "Response Body for GET signup" do
      it "response body contains signup form when there is NO current user" do
        allow(routing_helper).to receive(:current_user) { false }
        get '/signup'
        expect(last_response.body).to include("<form action=\"/signup\" method=\"post\">")
      end

      it "response body is empty when THERE IS A current user, due to the redirect" do
        allow(routing_helper).to receive(:current_user) { true }
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

    it 'redirects after creating a new with 302 status' do
      allow(RoutingHelper).to receive(:create_user) { user }
      post '/signup', params
      expect(last_response.status).to eq(302)
    end

    describe '#create' do
      it 'creates new user' do
        total_users_before = User.all.count
        new_user = UserController::RegistrationController.new(params).create
        expect(User.all.count).to eq(total_users_before + 1)
      end
    end

  end

  describe 'GET sign-in' do
    let(:routing_helper) { RoutingHelper }

    context "http responses depending on current user status" do
      it "returns 200 response when THERE IS NO current_user" do
        allow(routing_helper).to receive(:current_user) { false }
        get '/sign-in'
        expect(last_response.status).to eq(200)
      end

      it "returns 302 when THERE IS A current_user" do
        allow(routing_helper).to receive(:current_user) { true }
        get '/sign-in'
        expect(last_response.status).to eq(302)
      end
    end

    context "Response Body for GET sign-in" do
      it "response body contains sign-in form when THERE IS NO current user" do
        allow(routing_helper).to receive(:current_user) { false }
        get '/sign-in'
        expect(last_response.body).to include("<form action=\"/sign-in\" method=\"post\">")
      end

      it "response body is empty when THERE IS A current user, due to the redirect" do
        allow(routing_helper).to receive(:current_user) { true }
        get '/sign-in'
        expect(last_response.body).to include("")
      end
    end

    describe "POST /sign-in" do
      let(:params) { {"user" => { "email" => "ending@jess.com", "password" => "flex324G$9m"} } }
      let(:user_params) { {"first_name" => "Rose", "last_name" => "Tomas", "email" => "ending@jess.com",
        "password" => "flex324G$9m", "password_confirmation" => "flex324G$9m"} }

      it 'redirects after sign-in giving a 302 status' do
        user = object_double( User.create(user_params), :id => 5 )
        allow(RoutingHelper).to receive(:fetch_user) { user }
        post '/sign-in', params
        expect(last_response.status).to eq(302)
      end
    end

    describe '#fetch' do
      let(:user_params) { { :user => {first_name: "Ernest", last_name: "Smith", email: "uncle-pins@live.com",
        password: "password", password_confirmation: "password"} } }
      let(:sign_in_params) { {:user => {email: "uncle-pins@live.com", password: "password"} } }
      let(:registrar) { UserController::RegistrationController.new(sign_in_params) }

      it 'return user' do
        user = User.create( user_params[:user] )
        fetched_user = registrar.fetch
        expect(fetched_user).to eq(user)
      end

    end

  end

end

      # File.open('./test_log.html', 'w') do |f|
      #   f.puts last_response.body
      # end





