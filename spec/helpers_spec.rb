
describe Helpers::Params do

  subject { Helpers::Params }

  describe '#require' do
    it "returns the existing nested hash with key = model" do
      dirty_params = {
          client: {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          },
          injection: "SQL injection script"
        }
      model = "client"
      required_params = {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          }
      params = subject.new(dirty_params)

      expect( params.require(model) ).to eq( required_params )
    end

    it "returns the existing nested hash with key = model, even if params keys are strings and model is a string" do
      dirty_params = {
          "client" => {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          },
          injection: "SQL injection script"
        }
      model = "client"
      required_params = {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          }
      params = subject.new(dirty_params)

      expect( params.require(model) ).to eq( required_params )
    end

    it "returns the existing nested hash with key = model, even if params keys are strings and model is a symbol" do
      dirty_params = {
          "client" => {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          },
          injection: "SQL injection script"
        }
      model = :client
      required_params = {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          }
      params = subject.new(dirty_params)

      expect( params.require(model) ).to eq( required_params )
    end

    it "returns nil if there is no hash where the key = model" do
      dirty_params = {
          client: {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          },
          injection: "SQL injection script"
        }
      model = "user"
      required_params = nil
      params = subject.new(dirty_params)

      expect( params.require(model) ).to eq( required_params )
    end

  end

  describe '#permit' do
    it "returns hash with whitelisted key(s), even if whitelisted keys are string types, and params keys are symbols" do
      dirty_params = {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          }
      whitelist = ["first_name", "last_name", "email", "password"]
      required_params = {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password"
          }
      params = subject.new(dirty_params)

      expect( params.permit(whitelist) ).to eq( required_params )
    end

    it "returns hash with whitelisted key(s), even if whitelisted keys are string types, and params keys are strings" do
      dirty_params = {
            "first_name" => "Kofi",
            "last_name" => "Ayo",
            "email" => "jesus@hotmail.com",
            "password" => "password",
            "wrongkey" => "bogus value"
          }
      whitelist = ["first_name", "last_name", "email", "password"]
      required_params = {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password"
          }
      params = subject.new(dirty_params)

      expect( params.permit(whitelist) ).to eq( required_params )
    end

    it "returns hash with whitelisted key(s), even if whitelisted keys are symbols types, and params keys are strings" do
      dirty_params = {
            "first_name" => "Kofi",
            "last_name" => "Ayo",
            "email" => "jesus@hotmail.com",
            "password" => "password",
            "wrongkey" => "bogus value"
          }
      whitelist = [:first_name, :last_name, :email, :password]
      required_params = {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password"
          }
      params = subject.new(dirty_params)

      expect( params.permit(whitelist) ).to eq( required_params )
    end

    it "returns hash with whitelisted key(s), even if whitelisted keys are symbol types, and params keys are symbols" do
      dirty_params = {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          }
      whitelist = [:first_name, :last_name, :email, :password]
      required_params = {
            first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password"
          }
      params = subject.new(dirty_params)

      expect( params.permit(whitelist) ).to eq( required_params )
    end

  end


end