require File.expand_path("../../../../lib/database_module", __FILE__ )
require File.expand_path("../../../models/user", __FILE__ )

module UserController

  class SessionsController
    def self.create(params)
      # create session and save data
      user_params = clean_user_params(params)
      user = User.find_by( email: user_params["email"])

      if user && (user.password == user_params[:password])
        return user
      else
        puts "You've entered an incorrent email and password combination."
      end

      # "Welcome #{params[:email]}. Password is #{params[:password]}"
    end

    def self.update(params)
      "Testing update"
    end

    def self.delete(session)
      session[:user_id] = nil
      return session
    end


    private
      def self.clean_user_params(dirty_params)
        strong_params( dirty_params, "user", [ "email", "password" ] )
      end

      def self.strong_params( dirty_params, model, whitelist )
        clean_params = {}
        clean_params[model] = {}

        whitelist.each do |key|
          clean_params[model][key] = dirty_params[model][key] if dirty_params[model].has_key?(key)
        end

        clean_params[model]
      end

  end

end