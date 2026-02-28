Rails.application.routes.draw do 
  
    devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :edit_upgrade
      patch :upgrade
      patch :withdraw
    end
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_up', to: 'users/registrations#guest_create'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  get 'guest_signup', to: 'users#guest_signup'
  post 'guest_signup', to: 'users#create_guest'

  

  resources :posts do
    resources :post_comments, only: [:create, :destroy]
  end
  resources :categories, only: [:index, :show]
  get 'mypage' => 'users#mypage', as: 'mypage'
  root to: 'homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/search', to: 'searches#search'
end
