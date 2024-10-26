Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :posts do
    post 'like', to: 'likes#create', as: 'like'
    delete 'unlike', to: 'likes#destroy', as: 'unlike'

    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  resources :profiles, only: [:new, :create, :show, :index, :edit, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
end
