Rails.application.routes.draw do

  devise_for :users
  root 'products#index'

  get  'users/signout'  =>  'users#signout'

  get '/users/identification' => 'users#identification'

  get '/users/creditcard' => 'users#creditcard'

  resources :products, only: [:show, :new, :create] do
    resources :purchases, only: [:new, :create]
  end

  resources :users, only: [:new, :show, :edit] do
    resources :user_details, only: [:new, :create, :edit, :update, :show]
  end


end
