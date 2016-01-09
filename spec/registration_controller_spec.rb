# Unit test for RegistrationController

describe UserController::RegistrationController do

  describe 'strong params only allows whitelisted key-value pairs through' do
    it "can handle model and whitelist parameters as a string and an array of strings, respectively" do

      dirty_params = {
        client: {
          first_name: "Kofi",
          last_name: "Ayo",
          email: "jesus@hotmail.com",
          password: "password",
          wrong_key: "bogus value"
        },
        injection: "SQL injection script"
      }

      model = "client"
      whitelist = ["first_name", "last_name", "email", "password"]

      expect( UserController::RegistrationController.strong_params( dirty_params, model, whitelist ) ).to eq({
          first_name: "Kofi",
          last_name: "Ayo",
          email: "jesus@hotmail.com",
          password: "password"
        })

    end

    it "can handle the application params with strings instead of symbols for the keys in the params hash" do
      dirty_params = {
        "client" => {
          first_name: "Kofi",
          last_name: "Ayo",
          email: "jesus@hotmail.com",
          password: "password",
          wrong_key: "bogus value"
        },
        injection: "SQL injection script"
      }

      model = "client"
      whitelist = ["first_name", "last_name", "email", "password"]

      expect( UserController::RegistrationController.strong_params( dirty_params, model, whitelist ) ).to eq({
          first_name: "Kofi",
          last_name: "Ayo",
          email: "jesus@hotmail.com",
          password: "password"
        })

    end

    it "can handle the application params with nested keys that are strings instead of symbols" do
      dirty_params = {
        "client" => {
          "first_name" => "Kofi",
          last_name: "Ayo",
          email: "jesus@hotmail.com",
          password: "password",
          wrong_key: "bogus value"
        },
        injection: "SQL injection script"
      }

      model = "client"
      whitelist = ["first_name", "last_name", "email", "password"]

      expect( UserController::RegistrationController.strong_params( dirty_params, model, whitelist ) ).to eq({
          first_name: "Kofi",
          last_name: "Ayo",
          email: "jesus@hotmail.com",
          password: "password"
        })

    end

    it "will raise an exception error if the model parameter is not a key of the application Params" do
      dirty_params = {
        "user" => {
          "first_name" => "Kofi",
          last_name: "Ayo",
          email: "jesus@hotmail.com",
          "password" => "password",
          wrong_key: "bogus value"
        },
        injection: "SQL injection script"
      }

      model = "client"
      whitelist = ["first_name", "last_name", "email", "password"]

      expect { UserController::RegistrationController.strong_params( dirty_params, model, whitelist ) }.to raise_error(RuntimeError, "No key found for :#{model} or #{model.to_s}")
    end

  end

end