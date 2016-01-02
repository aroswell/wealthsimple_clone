require File.expand_path("../../../lib/database_module", __FILE__ )
require File.expand_path("../../models/user", __FILE__ )

module App

  def self.current_user(session)
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end


