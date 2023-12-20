Rails.application.routes.draw do
  devise_for :users

  root to: "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users do
    resources :groups, only: [:new, :create, :edit, :update, :destroy, :show] do
      resources :members, only: [:new, :create]
    end
    end

    resources :groups, only: [:index, :show]

    get "solo_game", to: "games#solo_game"

  resources :members, only: [:destroy, :show, :index] do
    get "group_game", to: "games#group_game"
    resources :dares
  end


end
