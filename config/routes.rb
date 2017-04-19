Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/signup", to: "users#new"

  resources :users
end
