Rails.application.routes.draw do
  devise_for :users
  default_url_options :host => "localhost:3000"

  get '/s/:short_url', to: 'pages#show', as: :short
  root 'static_pages#index'

  resources :users do
    resources :pages, only: [:index, :create, :new]
  end

end
