Rails.application.routes.draw do
  

  resources :new_cds

  resources :cds

  root to: 'new_cds#new'
end
