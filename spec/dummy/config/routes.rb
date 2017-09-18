Rails.application.routes.draw do
  mount SsoAuth::Engine, at: "/sso"

  root 'pages#index'
end
