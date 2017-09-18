class SsoAuthGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  desc "Creates SsoAuth initializer and mount sso routes."

  def copy_initializer
    template "sso_auth.rb", "config/initializers/sso_auth.rb"
  end

  def add_sso_auth_routes
    route "mount SsoAuth::Engine => '/sso', as: 'sso'"
  end
end
