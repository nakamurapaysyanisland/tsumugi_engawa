Rails.application.routes.draw do
  devise_for :user
  resources :users
  resources :posts
 
  root to: 'homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
