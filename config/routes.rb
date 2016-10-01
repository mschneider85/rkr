Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  resources :snippets
  resources :votes, only: [:create] do
  end
  root 'home#index'
end
