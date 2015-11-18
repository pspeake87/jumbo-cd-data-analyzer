Rails.application.routes.draw do
  

 devise_for :users,
    controllers: {:registrations => "registrations"}
  
  resources :transactions

  resources :new_cds
  
  resources :users
  
  resources :cds

  as :user do
     get "/register", to: "registrations#new", as: "register"
  end

  
  root :to => "welcome#index"

  
end
