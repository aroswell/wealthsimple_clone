require File.expand_path("../../../../lib/database_module", __FILE__ )
require File.expand_path("../../../models/user", __FILE__ )

module UserController

  class SessionsController
    def self.create(params)
      # create session and save data

      "Welcome #{params[:email]}. Password is #{params[:password]}"
    end

    def self.update(params)
      "Testing update"
    end

    def self.delete(session)
      session[:user_id] = nil
      return session
    end

  end

end