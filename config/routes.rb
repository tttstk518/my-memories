Rails.application.routes.draw do
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
    resources :articles, only: [:index, :show, :edit, :update]
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
