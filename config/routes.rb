Rails.application.routes.draw do
  

  devise_for :users
  resources :new_cds

  resources :cds

  root to: 'new_cds#new'

  
end
