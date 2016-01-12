# Unit and Controller test for RegistrationController

require File.expand_path( "../../bin/server", __FILE__ )
require "rack/test"


describe UserController::RegistrationController do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET signup' do
    it "renders signup page" do
      get '/signup'
      expect(last_response).to be_ok
    end

  end


end