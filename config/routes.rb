Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments,only: [:create, :destroy]
  end
  root 'home#top'
  resources :home,only: [:index]
  get 'home/about'
end