require File.expand_path( "../../bin/server", __FILE__ )
require "rack/test"

describe 'UserController::SessionsController' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end



  describe 'DELETE logout' do
    it 'redirects after logout' do
      allow(RoutingHelper).to receive(:delete_user_session) { puts "____Mock method called. User session gone!!____" }
      delete '/logout'
      expect(last_response.status).to eq(302)
    end

  end

end

      # File.open('./test_log.html', 'w') do |f|
      #   f.puts last_response.body
      # end

