# unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__))) do
#   $LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
# end

# Test
# puts File.dirname( __FILE__ ) + "/static"
module Helpers

  class Params < Hash

    def initialize(hash={})
      @clone = self.clone

      hash.each do |k1,v1|
        self[k1] = unless v1.class == Hash
                       v1
                    else
                      Params.new(v1)
                    end
      end
      keys_to_symbols
    end

    def keys_to_symbols
      self.keys.each do |key|
        key_to_symbol(key)
      end
      self
    end

    def require(model)
      self[model.to_sym]
    end

    def permit(whitelist_array)
      # create a hash to hold the strong params
      clean_params = cloned

      whitelist_array.each do |key|
        key = key.to_sym
        clean_params[key] = self[key] if self.has_key?(key)
      end

      clean_params
    end

    def [](key)
      value = (fetch key, nil) || (fetch key.to_s, nil) || (fetch key.to_sym, nil)
    end

    def []=(key,val)
      if (key.is_a? String) || (key.is_a? Symbol) #clear if setting str/sym
          self.delete key.to_sym
          self.delete key.to_s
      end
      merge!({key => val})
    end


    private
      # change the key inside the params object to a symbol
      def key_to_symbol(key)
        self[key.to_sym] = self.delete key
      end

      def cloned
        @clone
      end

  end

end




class Test
  include Helpers
  attr_reader :params

  def initialize
    @params = Params.new
  end

  def hey
    "wow"
  end
end

# app_params = {"user" => {"name" => "Jim", "email" => "jimmy-up@bizzy.com", "passwd" => "geronimo"}, "injection" => "SQL script"}
params = {first_name: "Kofi",
            last_name: "Ayo",
            email: "jesus@hotmail.com",
            password: "password",
            wrongkey: "bogus value"
          }

# b = Helpers::Params.new(params)
# puts b

ppl = Helpers::Params.new
puts ppl
ppl[:name] = "Kwame"
puts ppl["name"]
ppl["name"] = "Ayana"
puts ppl["name"]
puts ppl[:name]







# puts b.require("user")
# f = b.require("user").permit([ "passwd" ])
# f = b.permit(["first_name", "last_name", "email", "password"])
# puts f

# class ObscuringReferences
#  attr_reader :data
#  def initialize(data)
#   @data = data
#  end

#  def diameters
#    # 0 is rim, 1 is tire
#    data.collect {|cell|
#    cell[0] + (cell[1] * 2)}
#  end
# end

# class RevealingReferences
#   attr_reader :wheels
#   def initialize(data)
#   @wheels = wheelify(data)
#   end

#   def diameters
#    # 0 is rim, 1 is tire
#    wheels.collect {|wheel|
#    wheel.rim + (wheel.tire * 2)}
#   end

#   Wheel = Struct.new(:rim, :tire)
#   def wheelify(data)
#     data.collect {|cell|
#       Wheel.new(cell[0], cell[1])}
#   end

# end


# test = Test.new.params
# puts test.class


# data = [[622, 20], [622, 23], [559, 30], [559, 40]]
# o = ObscuringReferences.new(data)
# p o.diameters
# p o.data

# reveal =  RevealingReferences.new(data)
# p reveal.wheels[0]
# p reveal.wheels[0].class
# p reveal.diameters


