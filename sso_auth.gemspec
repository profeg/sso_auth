$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'sso_auth/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'sso_auth'
  s.version     = SsoAuth::VERSION
  s.authors     = ['Oleksii Ostanin']
  s.email       = ['tnd.prof@gmail.com']
  s.homepage    = 'https://github.com/profeg/sso_auth'
  s.summary     = 'SSO auth server.'
  s.description = 'Single-Sign-On Server for Rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 4.2.0'
  s.add_development_dependency 'rspec-rails', '~> 3.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'pry-rails'
end
