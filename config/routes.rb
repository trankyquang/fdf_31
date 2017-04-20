Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    resources :orders, only: [:show]
  end
  resources :orders
end
