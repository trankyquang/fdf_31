Rails.application.routes.draw do

  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :orders, only: :show
  resources :products
  resources :suggestings

  namespace :admin do
    resources :products
    resources :users, only: [:index, :destroy]
    resources :orders
    resources :suggestings, only: [:index, :show, :destroy]
    resources :categories
  end
end
