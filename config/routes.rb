Rails.application.routes.draw do
  devise_for :users
  default_url_options :host => "localhost:3030"
  get '/s/:short_url', to: 'pages#show', as: :short
  root 'static_pages#index'
end
