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
      if (key.is_a? String) || (key.is_a? Symbol) #clear existing values if setting str/sym
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