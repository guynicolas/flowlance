Rails.application.routes.draw do
  root to: 'pages#front'
  get 'home', to: "projects#index"
  get 'register', to: "users#new"
  resources :users, only: [:create] 
  get "login", to: "sessions#new"
  get "logout", to: "sessions#destroy"
  resources :sessions, only: [:create]
  get 'ui(/:action)', controller: 'ui'

  resources :projects, only: [:index, :new, :create]
end
