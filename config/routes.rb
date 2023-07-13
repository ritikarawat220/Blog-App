Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'devise/passwords' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root to: 'home#index'
  root 'users#index'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: [:create]
    end
  end

  
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
end
