Rails.application.routes.draw do
  resources :installments
  root to: 'static_pages#home'
  resources :pos 
  resources :statements, except: [:new, :create, :destroy]
  resources :participants
  resources :installements
  resources :line_items
  resources :po_users
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
  