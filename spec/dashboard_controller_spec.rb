require File.expand_path( "../../bin/server", __FILE__ )
require "rack/test"


describe DashboardController do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET /' do
    let(:user) { User.new }
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
        follow_redirect!
        expect(last_request.path).to eq('/sign-in')
      end
    end
    context 'current_user == true && approved' do
      it 'shows dashboard index page if current_user == true and current_user has been approved' do
        onboarded_user = object_double( user, :approved? => true, :admin? => false )
        allow(routing_helper).to receive(:current_user) { onboarded_user }
        get '/'
        expect(last_response.body).to include("<!-- Client dashboard -->")
      end
    end

    context 'current_user == true && current_user is not approved' do
      it 'returns redirect status if current_user == true but current_user is not approved' do
        allow(user).to receive(:approved?) { false }
        allow(routing_helper).to receive(:current_user) { user }
        get '/'
        expect(last_response.status).to eq(302)
      end

      it 'redirect to "/onboarding" if current_user == true but current_user is not approved' do
        allow(user).to receive(:approved?) { false }
        allow(routing_helper).to receive(:current_user) { user }

        get '/'
        follow_redirect!
        expect(last_request.path).to eq('/onboarding')
      end
    end

  end

end


# Code below used every now and then for debugging by viewing the response

# File.open('./test_log.html', 'w') do |f|
#   f.puts last_response.body
# end


