Rails.application.routes.draw do

  resources :proposals
  get 'homepage/home'
  root 'homepage#home'
  get 'homepage/about'
  get 'homepage/contact'
  get 'homepage' => 'homepage#home'
  get 'welcome' => 'welcome#index'
  get 'admin/index'
  get 'admin' => 'admin#index'
  get 'admin/user_table'
  get 'profile/setting'
  get 'profile/update', to: redirect("/profile/setting")
  get 'profile/:id' => 'profile#index'
  post 'profile/update'
  resources :courses
  get "/search", to: "courses#search"
  post 'comments' => 'comments#create'
  resources :comments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users,
          :skip => [:registrations]
  devise_scope :user do
    get "users/sign_up", to: "users/registrations#new", as: :new_user_registration
    post "users/sign_up", to: "users/registrations#create", as: :user_registration
  end
  get 'users/password', to: redirect("/users/password/new")
  
  
end
