Rails.application.routes.draw do

  namespace :admin do
    get 'favorites/index'
    get 'favorites/show'
  end
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :comments
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :favorites, only: [:index, :show]
  end
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    resources :articles
    get 'users/index' => 'users#index', as: 'users_top'
    get 'users/my_page' => 'users#show', as: 'my_page'
    get 'users/edit' => 'users#edit', as: 'users_edit'
    patch 'users/update' => 'users#update', as: 'users_update'
    get 'users/check' => 'users#check', as: 'users_check'
    patch 'users/withdrawal' => 'users#withdrawal', as: 'users_withdrawal'
    resources :favorites, only: [:index, :show]
  end
  #会員用
  # URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
end
