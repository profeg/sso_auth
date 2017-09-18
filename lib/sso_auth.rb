require 'sso_auth/engine'

module SsoAuth
  mattr_accessor :config

  def self.configure
    self.config = Configuration.new

    yield config
  end
end

require 'sso_auth/session'
require 'sso_auth/helpers'
require 'sso_auth/configuration'
