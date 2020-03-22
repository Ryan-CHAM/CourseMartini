Rails.application.routes.draw do
  devise_for :users
  get 'homepage/home'
  root 'homepage#home'
  get 'homepage/about'
  get 'welcome' => 'welcome#index'
  # get 'account/signup'
  get 'sign-up' => 'account#signup'
  # get 'account/signin'
  get 'sign-in' => 'account#signin'
  get 'admin/user_table'
  resources :account, path: "sign-up", as: :account, only: [:create]
end
