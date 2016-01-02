require File.expand_path("../../../../lib/database_module", __FILE__ )
require File.expand_path("../../../models/user", __FILE__ )

module UserController
  class RegistrationController
    Db.connect


    def self.create(params)
      puts params.class
      user_params = clean_user_params(params)
      user = User.new(user_params)
      puts "Before save: user id is #{user.id}"
      if user.save
        # some kind of flash message goes here
        puts "New user saved successfully"
        puts "After save: user id is #{user.id}"
        return user
      else
        # error message raised here
        puts "Oops. Something went wrong while trying to save new user."
      end
    end

    def self.update(params)
      "Testing update"
    end

    def self.delete(params)
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



