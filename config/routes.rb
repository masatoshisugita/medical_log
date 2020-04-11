Rails.application.routes.draw do
  root to: "topics#index"

  get 'likes/create'
  get 'likes/destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :topics do
    resources :comments
  end

  get '/login',to: 'sessions#new'
  post '/login',to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'

  post "/likes/:topic_id/create", to: "likes#create"
  post "/likes/:topic_id/delete", to: "likes#delete"

  get '/search', to: 'topics#search'

  resources :relationships, only: [:create,:destroy]
  resources :account_activations, only: [:edit]
end
