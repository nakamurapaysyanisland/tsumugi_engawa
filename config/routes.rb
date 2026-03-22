Rails.application.routes.draw do 

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_up', to: 'users/registrations#guest_create'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  devise_for :users
  devise_for :admin, skip: [:registrations, :pasword], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    resources :dashboards, only: [:index]
    resources :post_comments, only: [:index, :destroy]
    resources :posts, only: [:show, :destroy]
    resources :users, only: [:show, :destroy, :index] do
      member do
        patch :withdraw
      end
    end

  end
  
  scope module: :public do
    get '/search', to: 'searches#search'
    resources :groups do #resoucesのs忘れないように
      resources :group_users, only: [:create, :destroy, :update, :index] 
    end
  
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :edit_upgrade
      patch :upgrade
      patch :withdraw
    end
  end
resources :notifications, only: [:index]
  

  get 'guest_signup', to: 'users#guest_signup'
  post 'guest_signup', to: 'users#create_guest'
  
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy] #単数形は/:idがURLに含まれない
  end
  resources :categories, only: [:index, :show]
  get 'mypage' => 'users#mypage', as: 'mypage'
  root to: 'homes#top'
  end
end
