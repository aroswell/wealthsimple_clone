module User

  class RegistrationController
    def self.create(params)
      # create user and save data

      "Welcome #{params[:first_name]} #{params[:last_name]}. Please confirm your email address: #{params[:email]}"
    end

    def self.update(params)
      "Testing update"
    end

    def self.delete(params)
      "User: #{params[:first_name]} #{params[:last_name]}, will be deleted."
    end

  end

end