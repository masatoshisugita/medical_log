Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  root to: "topics#index"
  resources :users
  resources :topics

  get '/login',to: 'sessions#new'
  post '/login',to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'
end
