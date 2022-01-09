Rails.application.routes.draw do

  devise_for :users

  namespace :admin do
      resources :companies, only: [ :index, :show, :edit, :update ]
      resources :saved_items, except: [ :new ]
          
      root to: "companies#index"
    end
    
  resources :discounts, only: [ :new, :create, :destroy ]
  resources :installments
  root to: 'pos#index'
  resources :pos do
    resources :installements, except: [ :new, :create ]
  end

  resources :statements, except: [ :new, :create, :destroy ] 
  resources :participants
  resources :line_items, only: [ :new, :create, :edit, :update, :destroy ]
  resources :po_users

  get :search_programs, controller: :line_items
  get :default_options, controller: :static_pages, path: 'defaults'
  
end