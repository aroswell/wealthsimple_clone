# require File.expand_path("../../../../helpers/helpers", __FILE__ )

module UserController
  class RegistrationController
    include Helpers

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
      def clean_user_params(dirty_params)
        strong_params( dirty_params, "user", ["first_name", "last_name", "email", "password"] )
      end

      def clean_user_params_for_signin(dirty_params)
        strong_params( dirty_params, "user", [ "email", "password" ] )
      end

      # def self.strong_params( dirty_params, model, whitelist )

      #   # Does dirty_params have a key=model or a key=model.to_sym?
      #   unless dirty_params.has_key?(model.to_sym) || dirty_params.has_key?(model.to_s)
      #     raise "No key found for :#{model} or #{model.to_s}"
      #   end

      #   # convert model to symbol
      #   # convert all keys to symbols
      #   model = model.to_sym if model.class == String
      #   dirty_params = convert_hash_keys_to_symbols(dirty_params)
      #   dirty_params[model] = convert_hash_keys_to_symbols(dirty_params[model])
      #   whitelist.collect! do |key|
      #     key.to_sym
      #   end

      #   # create a hash to hold the strong params
      #   clean_params = {}
      #   clean_params[model] = {}

      #   whitelist.each do |key|
      #     clean_params[model][key] = dirty_params[model][key] if dirty_params[model].has_key?(key)
      #   end

      #   return clean_params[model]
      # end

      # def self.convert_hash_keys_to_symbols(hash)
      #   hash.keys.each do |key|
      #     hash[key.to_sym] = hash.delete key
      #   end
      #   return hash
      # end

  end

end




