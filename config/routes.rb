Rails.application.routes.draw do
  
  get 'users/new'
  devise_for :users
  
  root to: "books#home"
  resources :books, only: [:create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :edit, :update, :index]
  post 'users/:id', to: 'users#create' 
  get 'users/new', to: 'users#new'
  get 'books/confirm', to: 'books#confirm'
  get 'home/about', to: 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
