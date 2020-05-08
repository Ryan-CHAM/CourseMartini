=begin
    ROUTES
    PURPOSE: this file controls the routing of the website
             insures the correct response to html calls
=end
Rails.application.routes.draw do
  	# Route for homepage
	get 'homepage/overview'
	get 'homepage/index'
	# Set root path
	root 'homepage#index'
	get 'homepage' => 'homepage#index'
	get 'homepage/about'
	get 'homepage/contact'

	# Route for welcome page
	get 'welcome' => 'welcome#index'

	# Route for admin
	get 'admin/index'
	get 'admin' => 'admin#index'
	get 'admin/user_table'

	# Route for profile
	get 'profile/setting'
	get 'profile/update', to: redirect("/profile/setting")
	get 'profile/:id' => 'profile#index'
	get 'profile/comments/:id' => 'profile#comments'
	post 'profile/update'

	# Route for courses
	resources :courses
	get "/search", to: "courses#search"
	get "/random", to: "courses#random"
=begin
	resource is a set of routes combined together, for example, in the case of courses
	"resources :courses"  generates
			     GET    /courses(.:format)          courses#index
			     POST   /courses(.:format)          courses#create
	new_courses  GET    /courses/new(.:format)      courses#new
	edit_courses GET    /courses/:id/edit(.:format) courses#edit
		courses  GET    /courses/:id(.:format)      courses#show
			     PATCH  /courses/:id(.:format)      courses#update
			     PUT    /courses/:id(.:format)      courses#update
			     DELETE /courses/:id(.:format)      courses#destroy
=end 

	# Route for comments
	post 'comments' => 'comments#create'
	resources :comments

	# Route for proposals
	resources :proposals
	
	# Route for users
	devise_for :users,
			:skip => [:registrations]
	devise_scope :user do
		get "users/sign_up", to: "users/registrations#new", as: :new_user_registration
		post "users/sign_up", to: "users/registrations#create", as: :user_registration
	end
	get 'users/password', to: redirect("/users/password/new")
  
  
end
