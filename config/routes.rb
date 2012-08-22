Emailify::Application.routes.draw do

  resources :users
  # send current user to batmanjs (match before resources)
  match "sessions/current", :to => "sessions#current"
  resources :sessions
  resources :stops

  match "signup", :to => "users#new"
  match "login", :to => "sessions#new"
  match "logout", :to => "sessions#destroy"
  match "home", to: "home#index"

  root :to => "home#landing"
end
