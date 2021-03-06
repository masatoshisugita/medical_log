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
    post :import, on: :collection
    resources :comments, only: [:create, :destroy]
  end

  get '/login',to: 'sessions#new'
  post '/login',to: 'sessions#create'
  post '/guest_sign_in', to: 'sessions#new_guest'
  delete '/logout',to: 'sessions#destroy'

  post "/likes/:topic_id/create", to: "likes#create"
  post "/likes/:topic_id/delete", to: "likes#delete"
  get "/likes/:user_id/index", to: "likes#index"

  get '/search', to: 'topics#search'

  resources :relationships, only: [:create,:destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new,:create,:edit,:update]
  
end
