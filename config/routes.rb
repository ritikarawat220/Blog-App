Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'devise/passwords' }

  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'

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