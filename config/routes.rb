Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
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

  resources :users, only: [] do
    post :impersonate, on: :member, to: "users/pretender#impersonate"
    post :stop_impersonating, on: :collection, to: "users/pretender#stop_impersonating"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
