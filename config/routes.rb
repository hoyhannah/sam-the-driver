Rails.application.routes.draw do
  resources :products, only: [:index]
  resources :cart_items, only: %i[show index create update destroy]
  resources :carts, only: %i[show index create update destroy] do
    member do
      get :summary, to: 'carts#summary'
      get :current, to: 'carts/current'
    end
  end
  post '/login', to: 'sessions#create'
  resources :users, only: [:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
