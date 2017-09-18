class User < ActiveRecord::Base
  def valid_password?(password)
    password == self.password
  end
end
