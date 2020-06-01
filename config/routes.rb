Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :caves, only: [:index, :new, :create, :show, :update, :edit]
  resources :wines, only: [:index, :show] do
    resources :bottles, only: [:new, :create]
  end
  resources :bottles, only: [:edit, :show, :update]
  get 'toreview', to: 'bottles#toreview'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
