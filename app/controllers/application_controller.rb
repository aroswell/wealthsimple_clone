require 'active_record'

module App

  def self.current_user(session)
    # current_user ||= User.find(session[:user_id]) if session[:user_id]
    false
  end

end