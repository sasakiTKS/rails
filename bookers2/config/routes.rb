Rails.application.routes.draw do
  root to: 'homes#top'
  get "home/about"  => "homes#about", as: "about"
  devise_for :users
  resources :users, only: [:show, :edit, :index, :update]
  resources :books, only: [:show, :edit, :index, :update, :new, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
