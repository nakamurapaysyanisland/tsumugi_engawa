Rails.application.routes.draw do
  resource :users, only:[:show, :edit, :update, :unsubscrilbe, :withdraw, :index]
  resource :posts
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
