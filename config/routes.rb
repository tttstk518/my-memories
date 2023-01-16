Rails.application.routes.draw do

  namespace :admin do
    get 'favorites/index'
    get 'favorites/show'
  end
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :favorites, except: [:index] do
    resource :favorites, only: [:create, :destroy]
    end
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'

    resources :articles

    # get 'users/index' => 'users#index', as: 'users_top'
    get 'users/:id' => 'users#show', as: 'my_page'
    get 'users/:id/edit' => 'users#edit', as: 'users_edit'
    patch 'users/:id' => 'users#update', as: 'users_update'
    get 'users/check' => 'users#check', as: 'users_check'
    patch "/users/:id/withdrawal" => "users#withdrawal", as: 'withdrawal'
    get 'users/:id/favorites' => 'users#favorites', as: 'favorites'
    get 'search' => 'articles#search'
    resources :articles, except: [:index] do
      resources :favorites, only: [:create, :destroy, :show]
    end
  end

  #会員用
  # URL /customers/sign_in ...
  devise_for :users, controllers: {
  registrations: "public/registrations",
  passwords: 'users/passwords'
  }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
end
