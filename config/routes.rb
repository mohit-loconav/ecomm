Rails.application.routes.draw do
  get 'products/index'
  root 'statics#home'
  get 'login' => 'sessions#new'
  get 'signup' => 'users#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'category' => 'categories#index'
  resources :users, only: [:new, :create, :show]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :products, only: [:index, :show]
  resources :categories do
    resources :products, only: [:index]
  end
  resources :users do
    resources :cart_items, only: [:index, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
