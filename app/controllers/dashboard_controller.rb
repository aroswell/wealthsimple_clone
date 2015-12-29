module Dashboard

  def self.index(params)
    puts "Inside Dashboard module params = #{params}"
    puts "Printing from #{__FILE__}"
    "return string from index method contained in Dashboard module"
  end

  def self.onboarding
  end

end