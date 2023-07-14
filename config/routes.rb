Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  # namespace :api do
  #   namespace :v1 do
  #     get 'posts/index'
  #   end
  # end
  # namespace :api do
  #   namespace :v1 do
  #     get 'users/index'
  #   end
  # end
  # devise_for :users
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'devise/passwords' }
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root to: 'home#index'
  root 'users#index'

  # Non-API routes
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'

  # API routes
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end