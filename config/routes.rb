Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :line_items
      resources :expense_items
      resources :service_items
      resources :pos
      resources :participants
      resources :associates
      resources :clients
      resources :installments
      resources :saved_items
      resources :saved_services
      resources :saved_expenses
      resources :statements
      resources :associate_statements
      resources :general_statements
      resources :client_statements
      resources :payments
      resources :groups
      resources :po_users
      resources :details
      resources :statement_notes
      resources :companies
      resources :members
      resources :saved_details
      resources :discounts

      root to: "users#index"
    end
  resources :discounts, only: [ :new, :create, :destroy ]
  resources :installments
  resources :saved_items
  root to: 'pos#index'
  resources :pos do
    resources :installements, except: [ :new, :create ]
  end

  resources :statements, except: [ :new, :create, :destroy ] 
  resources :participants
  resources :line_items, only: [ :new, :create, :edit, :update, :destroy ]
  resources :po_users
  # namespace :form_validations do
  #   resources :line_items, only: [:create, :update]
  # end

  devise_for :users

  get :search_programs, controller: :line_items
  
end
  