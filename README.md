# SSO Auth Rails engine

## About

*SOON*

## Installation

Add engine (https://github.com/profeg/sso_auth) provider gems to your project:

```ruby
# Gemfile

gem 'sso_auth'
```

Install initializer and mount routes:

```bash
bin/rails generate - sso_auth
```

Configure initializer:

```ruby
# conifg/initializers/sso_auth.rb

SsoAuth.configure do |config|
end
```

And mount it:

```ruby
# config/routes.rb

Rails.application.routes.draw do
  mount SsoAuth::Engine => '/sso', as: 'sso'
end
```

## Usage

