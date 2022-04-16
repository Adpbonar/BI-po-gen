Rails.application.routes.draw do

  resources :invoices
  resources :inoices
  devise_for :users

  namespace :admin do
      resources :saved_items, except: [ :new ]
      resources :companies, only: [ :index, :show, :edit, :update ]    
      root to: "saved_items#index"
    end
    
  resources :discounts, only: [ :new, :create, :destroy ]
  resources :installments
  root to: 'pos#index'
  resources :pos
  resources :statement_notes, only: [ :edit, :update ]
  resources :statements, except: [ :destroy ] 
  resources :participants
  resources :line_items, only: [ :new, :create, :edit, :update, :destroy ]
  resources :items, except: [ :index, :show ]

  get :search_programs, controller: :line_items
  get :default_options, controller: :static_pages, path: 'defaults'
end 