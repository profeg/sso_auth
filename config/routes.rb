SsoAuth::Engine.routes.draw do
  # resource :sso, only: [:index, :create, :delete]
  get '/session', to: 'session#index'
  post '/session', to: 'session#create'
end
