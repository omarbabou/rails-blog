Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "users#index"
  # Define endpoints for
  post "/api/register", to: 'authentication#register'
  post '/api/login', to: 'authentication#login'
  get '/api/users/:user_id/posts', to: 'posts#posts'
  get '/api/posts/:id/comments', to: 'comments#comments'
  get '/api/users/:user_id/posts/:id/comments', to: 'all#comments'
  post '/api/users/:user_id/posts/:id/comments', to: 'comments#add_comment'

  resources :users, only: [:index, :show] do
resources :posts, only: [:index, :show, :new, :create, :destroy] do      
  resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
  end
  end
end