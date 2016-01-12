
describe Helpers::Params do

  subject { Helpers::Params }

  describe '#require' do
    it "returns nested hash with key = model" do
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

    it "returns nil if key = model does not exist" do
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
    it "returns hash with whitelisted key(s)" do
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

  end


end