Rails.application.routes.draw do
  root to: "users#index"
  resources :users
  resources :topics

  get '/login',to: 'sessions#new'
  post '/login',to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'
end
