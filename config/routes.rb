Rails.application.routes.draw do
  root to: 'pages#front'
  get 'home', to: "projects#index"
  get 'register', to: "users#new"
  resources :users, only: [:create] 
  get "login", to: "sessions#new"
  get "logout", to: "sessions#destroy"
  resources :sessions, only: [:create]
  get 'ui(/:action)', controller: 'ui'

  resources :projects, only: [:index, :new, :create] do 
    member do 
      patch :complete
    end 
  end 
  
  get "forgot_password", to: "forgot_passwords#new"
  resources :forgot_passwords, only: [:create]
  get "forgot_password_confirmation", to: "forgot_passwords#confirm"
  resources :password_resets, only: [:show, :create] 
  get "expired_token", to: "password_resets#expired_token"

end
