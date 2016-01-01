require File.expand_path("../../../../lib/database_module", __FILE__ )
require File.expand_path("../../../models/user", __FILE__ )


module UserController
  class RegistrationController
    Db.connect
    def self.create(params)
      # create user and save data
      User.all.each do |user|
        puts user.first_name
      end

      # "Welcome #{params[:first_name]} #{params[:last_name]}. Please confirm your email address: #{params[:email]}"
      "this is a test"
    end

    def self.update(params)
      "Testing update"
    end

    def self.delete(params)
      "User: #{params[:first_name]} #{params[:last_name]}, will be deleted."
    end

  end

end

# puts User.first.first_name
# puts UserController::RegistrationController.create("no")



