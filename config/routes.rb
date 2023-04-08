Rails.application.routes.draw do
  resources :products, only: [:index]
  resources :checkouts, only: [:create]
  resources :cart_items, only: %i[show index create update destroy]
  resources :carts, only: %i[show index create update destroy] do
    member do
      get :summary, to: 'carts#summary'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
