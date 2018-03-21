Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :composts, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get 'remove', to: 'composts#remove'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
