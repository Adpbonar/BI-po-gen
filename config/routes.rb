Rails.application.routes.draw do
  resources :pos do 
    resources :statements
    resources :participants
    resources :installements
    resources :line_items
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
