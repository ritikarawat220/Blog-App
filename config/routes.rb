Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root to: 'home#index'
  root 'users#index'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :comments, only: %i[new create]
      resources :likes, only: [:create]
    end
  end

  # post '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
end