Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'users/delete'

  devise_for :users, controllers: { registrations: "registrations"}
  resources :users, only: [:show, :edit, :update, :destroy]
  root 'home#index'
  resources :waitlists
  resources :courses do
    resources :enrollments
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
