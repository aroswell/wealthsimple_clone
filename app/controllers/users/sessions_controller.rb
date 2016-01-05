# require File.expand_path("../../../../lib/database_module", __FILE__ )
require File.expand_path("../../../models/user", __FILE__ )

module UserController

  class SessionsController

    def self.create(session, user)
      session[:user_id] = user.id unless user.nil?
    end

    def self.update(params)
      "Testing update"
    end

    def self.delete(session)
      session[:user_id] = nil
    end

    def self.current_user(session)
      # Db.connect
      current_user ||= User.find(session[:user_id]) if session[:user_id]
      # Db.release
      return current_user
    end

  end

end