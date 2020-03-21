Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome' => 'welcome#index', :as => "welcome"
  # get 'account/signup'
  get 'sign-up' => 'account#signup'
  #get 'account/signin'
  get 'sign-in' => 'account#signin'
  get 'admin/user_table'
  resources :account, path: "sign-up", as: :account, only: [:create]
end
