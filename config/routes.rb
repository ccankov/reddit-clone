Rails.application.routes.draw do
  resources :posts, except: [:index]
  resources :subs
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
end
