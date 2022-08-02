Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  namespace :admin do
    resources :users, only:[:index, :show, :edit, :update]
    resources :posts, only:[:index, :show, :destroy]
    resources :tags, only:[:index, :create, :edit, :update]
    resources :prefectures, only:[:index, :create, :edit, :update]
    resources :comments, only:[:index, :show, :destroy]
  end

  scope module: :public do
    root to: "homes#top"
    resources :users, only:[:index, :show, :edit, :update] do
      member do
        get :favorites
      end
      resource :relationships, only:[:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts, only:[:new, :create, :index, :show, :edit, :update, :destroy] do
      get :search, on: :collection
      resource :favorites, only:[:create, :destroy]
      resources :comments, only:[:create, :destroy]
    end
    resources :tags, only:[:index, :show]
    resources :prefectures, only:[:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
