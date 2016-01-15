require File.expand_path( "../../bin/server", __FILE__ )
require "rack/test"


describe DashboardController do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET /' do
    let(:routing_helper) { RoutingHelper }
    context 'current_user = nil' do
      it 'returns redirect status if current_user = nil' do
        allow(routing_helper).to receive(:current_user) { nil }
        get '/'
        expect(last_response.status).to eq(302)
      end

      it 'redirect to "/sign-in" if current_user = nil' do
        allow(routing_helper).to receive(:current_user) { nil }
        get '/'
        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_request.path).to eq('/sign-in')
      end
    end
    context 'current_user == true && approved' do
      it 'shows dashboard index page if current_user == true and current_user has been approved' do
        user = object_double( User.create, :approved? => true )
        allow(routing_helper).to receive(:current_user) { user }
        get '/'
        expect(last_response.body).to include("<!-- Client dashboard -->")
      end
    end

    context 'current_user == true && current_user is not approved' do
      it 'returns redirect status if current_user == true but current_user is not approved' do
        user = object_double( User.create, :approved? => false )
        allow(routing_helper).to receive(:current_user) { user }
        get '/'
        expect(last_response.status).to eq(302)
      end

      it 'redirect to "/onboarding" if current_user == true but current_user is not approved' do
        user = object_double( User.create, :approved? => false )
        allow(routing_helper).to receive(:current_user) { user }
        get '/'
        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_request.path).to eq('/onboarding')
      end
    end

  end

end