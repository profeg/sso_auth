module SsoAuth
  class Configuration
    mattr_accessor :sso_secret, :sso_user
    def initialize
      self.sso_secret = 'IN09NKVG087NKYF764kjvjyyd1325415'
      self.sso_user = 'User'
    end
  end
end
