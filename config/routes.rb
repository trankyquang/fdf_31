Rails.application.routes.draw do
  root "products#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#destroy"
  get "/carts", to: "carts#index"
  post "/carts", to: "carts#create"
  put "/carts", to: "carts#update"
  delete "/carts", to: "carts#destroy"
  resources :users
  resources :orders
  resources :products
  resources :suggestings
  resources :cart, only: :index
  resources :categories
  resources :ratings, only: :create

  namespace :admin do
    resources :products
    resources :users, only: [:index, :destroy]
    resources :orders
    resources :suggestings, only: [:index, :show, :destroy]
  end
end
