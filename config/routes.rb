Rails.application.routes.draw do
  devise_for :users

  root to: "games#game_interface"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users do
    collection do
      get 'search'
    end
    resources :groups, only: [:new, :create, :edit, :update, :destroy, :show] do
      resources :members, only: [:create]
    end
  end

    resources :groups, only: [:index, :show]

    get "solo_game", to: "games#solo_game"
    get "game_interface", to: "games#game_interface"
    patch "/update_score", to: "games#update_score"

  resources :members, only: [:destroy, :show, :index] do
    get "group_game", to: "games#group_game"
    resources :dares
  end


end
