Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :posts do
    post 'like', to: 'likes#create', as: 'like'
    delete 'unlike', to: 'likes#destroy', as: 'unlike'

    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  get 'explore', to: 'explore#index', as: :explore

  resources :profiles, only: [:new, :create, :show, :index, :edit, :update] do
    member do
      post 'follow', to: 'follows#create', as: 'follow'
      post 'accept', to: 'follows#accept', as: 'accept_follow'
      delete 'reject', to: 'follows#reject', as: 'reject_follow'
      delete 'unfollow', to: 'follows#destroy', as: 'unfollow'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
end
