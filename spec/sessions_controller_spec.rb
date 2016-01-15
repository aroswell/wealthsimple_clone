require File.expand_path( "../../bin/server", __FILE__ )
require "rack/test"

describe 'UserController::SessionsController' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:session) { {} }
  let(:controller) { UserController::SessionsController.new }

  describe 'DELETE logout' do
    it 'redirects after logout' do
      allow(RoutingHelper).to receive(:delete_user_session) { puts "____Mock method called. User session gone!!____" }
      delete '/logout'
      expect(last_response.status).to eq(302)
    end
  end

  describe '#delete' do
    it 'removes user id from sessions hash' do
      session[:user_id] = 3
      controller.delete(session)
      expect(session[:user_id]).to eq(nil)
    end
  end

  describe '#create' do
    it 'puts user id in sessions hash' do
      user = object_double(User.new, :id => 12)
      session[:user_id] = nil
      controller.create(session, user)
      expect(session[:user_id]).to eq(12)
    end
  end

  describe '#current_user' do
    it 'if a user is logged in and a session has been create, returns user matching user id in sessions hash' do
      user = User.new({first_name: "Test", password: "password"})
      user.save
      puts "___#{user.id}___"
      session[:user_id] = user.id
      current_user = controller.current_user(session)
      expect(current_user).to eq(user)
    end

    it 'if NO sessions user id, returns nil for current_user' do
      session[:user_id] = nil
      current_user = controller.current_user(session)
      expect(current_user).to eq(nil)
    end
  end

end

      # File.open('./test_log.html', 'w') do |f|
      #   f.puts last_response.body
      # end

