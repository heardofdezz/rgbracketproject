Rails.application.routes.draw do

  resources :rg
  resources :users
  resources :sessions
  resources :tournois

  root 'rg#homepage'

  get 'bracketrg', to: 'rg#rg'
  get 'signup', to: 'users#new'
  post 'signup',  to: 'users#create'
  get 'login',   to: 'sessions#new'
  post 'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  #get 'user', to: 'users#index'

  get '/malesingle', to: 'tournois#malesingle'
  post '/malesingle', to: 'tournois#create'
end
