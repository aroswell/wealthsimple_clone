require File.expand_path("../../../../lib/database_module", __FILE__ )
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
      Db.connect

      current_user ||= User.find(session[:user_id]) if session[:user_id]
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