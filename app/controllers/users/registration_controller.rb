require File.expand_path("../../../../lib/database_module", __FILE__ )
require File.expand_path("../../../models/user", __FILE__ )

module UserController
  class RegistrationController

    def self.create(params)
      Db.connect

      user_params = clean_user_params(params)
      user = User.new(user_params)
      if user.save
        # some kind of flash message goes here
        puts "New user saved successfully"
        return user
      else
        # error message raised here
        puts "Oops. Something went wrong while trying to save new user."
      end
    end

    def self.fetch(params)
      Db.connect

      user_params = clean_user_params(params)
      user = User.find_by( email: user_params["email"])

      if user && (user.password == user_params[:password])
        return user
      else
        puts "You've entered an incorrect email and password combination."
        return nil
      end
    end

    def self.edit(params)
      # User can change email and password
      "Testing edit"
    end

    def self.update(params)
      # User can change email and password
      "Testing update"
    end

    def self.delete(params)
      # user or admin can destroy their account
      "User: #{params[:first_name]} #{params[:last_name]}, will be deleted."
    end

    private
      def self.clean_user_params(dirty_params)
        strong_params( dirty_params, "user", ["first_name", "last_name", "email", "password"] )
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

# puts User.first.first_name
# puts UserController::RegistrationController.create("no")



