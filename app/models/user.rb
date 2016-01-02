class User < ActiveRecord::Base
  has_secure_password

  def approved?
    # TODO via TDD
    false
  end
end