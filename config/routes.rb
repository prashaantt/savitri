Savitri::Application.routes.draw do
  get "search/index"

  get "search/results"


  get 'search' => 'search#index'
  get 'search/search' => 'search#search'
  get 'search/results' => 'search#results'

  resources :notebooks

  mount RedactorRails::Engine => '/redactor_rails'

  devise_for :users
  
  get "/profile/:id" => "users#show", :as => :profile

  get '/blogs/latest' => "blogs#latest"
  

  get '/search' =>  "lines#index"
  resources :blogs

  match "/store/notebooks" => "notebooks#create"

  match "/store/notesu" => "notebooks#update"

  match "/store/notesd" => "notebooks#destroy"

  match "/store/notess" => "notebooks#search"

  resources :read

  resources :follows, :only => [:create, :destroy]

  resources :users do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  
  get "savitri/index"
  match '/savitri/' => "savitri#index"
  # resources :users do
  #   resources :posts do
  #     resources :comments
  #   end
  # end

  resources :users do
   resources :blogs, :name_prefix => "user_"
  end

  resources :blogs do
    resources :posts, :name_prefix => "blog_"
  end

  resources :posts do
    resources :comments, :name_prefix => "post_"
  end


  get 'blogs/:blog_id/posts/tags/:tag' , to: 'posts#index' , as: :tag
  
  resources :books

  resources :sections
  
  resources :cantos

  resources :stanzas

  resources :lines

  get 'lines/range/:id', to: 'lines#range'

  root :to => 'savitri#index', :as => 'savitri'
end
