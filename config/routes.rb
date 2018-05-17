Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'dashboard', to: "composts#dashboard"
  get 'my_composts', to: 'composts#user_composts'

  resources :composts, except: [:edit] do
    member do
      get 'remove', to: 'composts#remove'
    end

    resources :messages, only: :create
  end

  resources :conversations, only: [] do
    resources :messages, only: :index
  end

  resources :users, only: [:index] do
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
