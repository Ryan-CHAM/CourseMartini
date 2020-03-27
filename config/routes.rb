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
  resources :courses
  get "/search", to: "courses#search"
  resources :comments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
