Rails.application.routes.draw do
  resources :discounts, only: [ :new, :create, :destroy ]
  resources :installments
  resources :saved_items
  root to: 'pos#index'
  resources :pos do
    resources :installements, except: [ :new, :create ]
  end

  resources :statements, except: [ :new, :create, :destroy ] 
    resources :line_items, except: [ :index, :show ]
  resources :participants
  resources :po_users
  namespace :form_validations do
    resources :line_items, only: [:create, :update]
  end

  devise_for :users
  
end
  