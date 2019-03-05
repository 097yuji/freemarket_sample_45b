Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :products, only: [:show, :new, :create] do
    resources :purchases, only: [:new, :create]
  end

  resources :users, only: [:show] do
    resources :user_details, only: [:new, :create, :edit, :update, :show]
  end


end
