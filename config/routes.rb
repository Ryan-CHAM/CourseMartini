Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome' => 'welcome#index', :as => "welcome"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'account/signup'
  get 'account/signin'
  get 'admin/user_table'
  resources :account
end
