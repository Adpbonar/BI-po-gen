Rails.application.routes.draw do
  resources :installments
  root to: 'static_pages#home'
  resources :pos do
    resources :installements, except: [ :new, :create ]
  end

  resources :statements, except: [ :new, :create, :destroy ] 
    resources :line_items
  resources :participants
  resources :po_users

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
  