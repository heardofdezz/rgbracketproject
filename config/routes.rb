Rails.application.routes.draw do

  resources :rg
  resources :users
  resources :sessions
  resources :tickets

  root 'rg#homepage'

  get 'bracketrg', to: 'rg#rg'
  get 'signup', to: 'users#new'
  post 'signup',  to: 'users#create'
  get 'login',   to: 'sessions#new'
  post 'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  get 'malesingle', to: 'tickets#new'
  #get 'user', to: 'users#index'
  post 'malesingle', to: 'tickets#create', via: :post
end
