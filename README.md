# SSO Auth Rails engine

## About

*SOON*

## Installation

Add gem to your rails project:

```ruby
# Gemfile

gem 'sso_auth'
```

Install initializer and mount routes:

```bash
bin/rails generate sso_auth
```

Configure initializer:

```ruby
# conifg/initializers/sso_auth.rb

SsoAuth.configure do |config|
  # default auth model
  config.sso_user = 'User'
  # Secret key for SSO signing
  config.sso_secret = ENV['SSO_SECRET_KEY']
end
```

## Usage

*SOON*

