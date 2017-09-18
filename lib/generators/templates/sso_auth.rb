SsoAuth.configure do |config|
  # default auth model
  config.sso_user = 'User'
  config.sso_secret = ENV['SSO_SECRET_KEY']
end
