# require File.expand_path("../../../../helpers/helpers", __FILE__ )

module UserController
  class RegistrationController
    include Helpers
    attr_reader :params

    def initialize(params={})
      @params = Params.new(params)
    end

    def create
      user_params = clean_user_params
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

    def fetch
      user_params = clean_user_params_for_signin
      user = User.find_by( email: user_params["email"])

      if user && (user.password == user_params[:password])
        return user
      else
        puts "You've entered an incorrect email and password combination."
        return nil
      end
    end

    def edit
      # User can change email and password
      "Testing edit"
    end

    def update
      # User can change email and password
      "Testing update"
    end

    def delete
      # user or admin can destroy their account
      "User: #{params[:first_name]} #{params[:last_name]}, will be deleted."
    end

    private
      def params
        @params
      end

      def clean_user_params
        params.require("user").permit( ["first_name", "last_name", "email", "password"] )
      end

      def clean_user_params_for_signin(dirty_params)
        strong_params( dirty_params, "user", [ "email", "password" ] )
      end

  end

end




