Rails.application.routes.draw do

  get 'likes/index'
  get 'likes/show'
  get 'likes/new'
  get 'likes/create'
  get 'likes/destroy'
  
  root 'home#show'

  get 'home', to: 'home#show'
  get 'welcome/:user_first_name', to: 'welcome#show'
  get 'team', to: 'team#show'
  get 'contact', to: 'contact#show'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :gossips do 
    resources :comments, except: [:index, :show]
    resources :likes, only: [:new, :create, :destroy]
  end
  resources :cities
  resources :profile, only: [:show, :edit, :update, :destroy]
  
end
