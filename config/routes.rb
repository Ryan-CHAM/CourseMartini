Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'account#signup'
  get 'account/signup'
  get 'account/signin'
  get 'admin/user_table'
  resources :account
end
