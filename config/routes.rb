Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  resources :snippets
  resources :links do
    get :load_preview, on: :collection
  end
  resources :votes, only: [:create] do
  end
  root 'home#index'
end
