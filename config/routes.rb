Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  resources :tags, only: :index
  resources :snippets, only: [:index, :new, :create] do
    get :language_code, on: :collection
  end
  resources :links, only: [:index, :new, :create] do
    get :load_preview, on: :collection
  end
  resources :votes, only: :create
  resources :posts, only: :index
  root 'home#index'
end
