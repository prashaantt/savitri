Savitri::Application.routes.draw do

  match '/ping' => "health#ping"

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :audios
  resources :media

  get "search/index"

  get "search/results"

  get 'search' => 'search#index'
  get 'search/search' => 'search#search'
  get 'search/results' => 'search#results'

  resources :notebooks

  get 'lines/range/:id', to: 'lines#range'
  get 'stanzas/range/:id', to: 'stanzas#range'
  get 'blogs/:blog_id/recentcomments', to: 'blogs#recentcomments', :defaults => {:format => :json}
  get 'blogs/:blog_id/recentposts', to: 'blogs#recentposts', :defaults => {:format => :json}

  devise_for :users
  
  get "/profile/:id" => "users#show", :as => :profile

  get '/search' =>  "lines#index"
  resources :blogs
  resources :uploads
  
  resources :signed_urls, :only => "index"

  match "/store/notebooks" => "notebooks#create"

  match "/store/notesu" => "notebooks#update"

  match "/store/notesd" => "notebooks#destroy"

  match "/store/notess" => "notebooks#search"

  match 'read/:book_id/:canto_id/:section_id' => 'read#show'
  match 'read/:book_id/:canto_id' => 'read#bookcantoshow'
  match 'read/:book_id' => 'read#specific', :constraints => {:book_id => /[^\/]+/ }

  resources :follows, :only => [:create, :destroy]

  resources :users do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  
  get "savitri/index"
  match '/savitri/show' => "savitri#show"

  resources :blogs do
   resources :posts, :name_prefix => "blog_"
  end

  resources :posts do
   resources :comments, :name_prefix => "post_"
  end

  resources :media do
   resources :audios, :name_prefix => "media_"
  end

  get 'blogs/:blog_id/posts/tags/:tag/feed', to: 'posts#index', as: :tag, :format=> false, :defaults => {:format => :atom}
  get 'blogs/:blog_id/posts/tags/:tag' , to: 'posts#index' , as: :tag
  get 'blogs/:blog_id/scheduled-posts/', to: 'posts#scheduled'
  get 'blogs/:blog_id/feed', to: 'posts#index', :format=> false, :defaults => {:format => :atom}
  get 'media/:medium_id/feed', to: 'audios#index', :format=> false, :defaults => {:format => :rss}

  resources :books

  resources :sections

  resources :cantos

  resources :stanzas

  resources :lines

  resources :pages, except: :show

  get ':id', to: 'pages#show', as: :page
  put ':id', to: 'pages#update', as: :page
  delete ':id', to: 'pages#destroy', as: :page

  root :to => 'savitri#index', :as => 'savitri'

  get '*paths' => 'pages#show', as: :page
  put '*paths' => 'pages#update', as: :page

end
