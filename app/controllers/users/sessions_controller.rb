# require File.expand_path("../../../models/user", __FILE__ )

module UserController

  class SessionsController

    def create(session, user)
      session[:user_id] = user.id unless user.nil?
    end

    def delete(session)
      session[:user_id] = nil
    end

    def current_user(session)
      current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

  end

end