# encoding: UTF-8
# routes.
Savitri::Application.routes.draw do
  resources :commentaries


  get "compare(/:book_id/:canto_id/:section_id)", to: 'compare#index'#, constraints: { id: /[^\/]+/ }
  get 'compare/update_books', :as => 'update_books'
  get 'compare/update_cantos', :as => 'update_cantos'
  get 'compare/update_sections', :as => 'update_sections'

  resources :authentications

  match '/ping' => 'health#ping'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
    resources :rewrites
    match 'dashboard/' => 'dashboard#index'
    resources :tasks
  end

  resources :audios
  resources :media

  get 'search' => 'search#index'

  resources :notebooks

  get 'lines/range/:id', to: 'lines#range'
  get 'stanzas/range/:id', to: 'stanzas#range'
  get 'blogs/:blog_id/recentcomments', to: 'blogs#recentcomments', defaults: { format: :json }
  get 'blogs/:blog_id/recentposts', to: 'blogs#recentposts', defaults: { format: :json }
  get 'blogs/:blog_id/get_oldest_post_date', to: 'blogs#get_oldest_post_date', defaults: { format: :json }
  devise_for :users

  get '/profile/:id' => 'users#show', as: :profile, :constraints  => { :id => /[0-z\.]+/ }
  get 'blogs/:id/authorized_users', to: 'blogs#authorized_users', as: :authorized_users
  post 'blogs/:id/invite_for_blog' => 'blogs#invite_for_blog'
  get 'blogs/:slug/remove_blog_access/:user_id', to: 'blogs#remove_blog_access', as: :remove_blog_access
  resources :blogs

  resources :uploads

  resources :signed_urls, only: 'index'

  match '/store/notebooks' => 'notebooks#create'
  match '/store/notesu' => 'notebooks#update'
  match '/store/notesd' => 'notebooks#destroy'
  match '/store/notess' => 'notebooks#search'

  match 'read/' => 'read#index'
  match 'read/:book_id/:canto_id/:section_id' => 'read#show'
  match 'read/:book_id/:canto_id' => 'read#bookcantoshow'
  match 'read/:book_id' => 'read#specific', constraints: { book_id: /[^\/]+/ }

  resources :follows, only: [:create, :destroy]
  match 'follows/blog_id/:blog_id', to: 'follows#follow_blog', as: :follow_blog, via: :post
  match 'follows/blog_id/:blog_id', to: 'follows#unfollow_blog', as: :unfollow_blog, via: :delete
  match 'unsubscribe_blog/:blog_id/:post_id', to: 'blogs#unsubscribe_blog', as: :unsubscribe_blog, via: :get
  get '/users/:id' => 'users#show', :constraints  => { :id => /[0-z\.]+/ }
  get '/users/:id/feed', to: 'users#show', :constraints  => { :id => /[0-z\.]+/ }, defaults: { format: :atom }
  resources :users do
    get '/users/sign_out' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  get 'savitri/index'
  match '/savitri/show' => 'savitri#show'
  match '/auth/:provider/callback', to: 'authentications#create'
  match '/auth/failure', to: 'authentications#index'

  resources :blogs do
    member do
      get 'series'
    end
    resources :posts, name_prefix: 'blog_'
  end

  resources :posts do
    resources :comments, name_prefix: 'post_'
  end

  post '/posts/:post_id/comments/notify', to: 'comments#notify', as: :comments_notify

  resources :media do
    resources :audios, name_prefix: 'media_'
  end

  get 'blogs/:blog_id/tags', to: 'posts#tags'
  get 'blogs/:blog_id/posts/tags/:tag/feed', to: 'posts#index', as: :tag, format: false, defaults: { format: :atom }
  get 'blogs/:blog_id/posts/tags/:tag' , to: 'posts#index' , as: :tag
  get 'blogs/:blog_id/scheduled-posts/', to: 'posts#scheduled', as: 'scheduled_posts'
  get 'blogs/:blog_id/deleted-posts/', to: 'posts#deleted', as: 'deleted_posts'
  put 'blogs/:blog_id/posts/:post_id/undelete', to: 'posts#undelete', as: 'undelete'
  get 'blogs/:blog_id/feed', to: 'posts#index', format: false, defaults: { format: :atom }
  get 'blogs/:blog_id/archives' , to: 'posts#archives', as: :archives
  get 'blogs/:blog_id/archives/:year' , to: 'posts#month_wise_post_count', as: :month_wise_post_count
  get 'blogs/:blog_id/archives/:year/:month' , to: 'posts#months_posts', as: :months_posts
  get 'media/:medium_id/feed', to: 'audios#index', format: false, defaults: { format: :rss }
  get 'blogs/:blog_id/posts/:post_id/update_featured_status', to: 'posts#update_featured_status', as: :update_featured_status
  get "blogs/:blog_id/:year" => "posts#index", :constraints => { :year => /\d{4}/ }, as: :filter_year
  get "blogs/:blog_id/:year/:month" => "posts#index", :constraints => { :year => /\d{4}/, :month => /\d{2}/ }, as: :filter_month
  get "blogs/:blog_id/:year/:month/:day" => "posts#index", :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ }, as: :filter_day
  resources :books

  resources :sections do
    member do
      get 'commentaries'
    end
  end

  resources :cantos

  resources :stanzas

  resources :lines

  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ }

  resources :pages, except: :show

  get ':id', to: 'pages#show', as: :page
  put ':id', to: 'pages#update', as: :page
  delete ':id', to: 'pages#destroy', as: :page

  root to: 'savitri#index', as: 'savitri'

  get '*paths' => 'pages#show', as: :page
  put '*paths' => 'pages#update', as: :page
end
