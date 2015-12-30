module User

  class SessionsController
    def self.create(params)
      # create session and save data

      "Welcome #{params[:email]}. Password is #{params[:password]}"
    end

    def self.update(params)
      "Testing update"
    end

    def self.delete(params)
      "Session destroyed."
    end

  end

end