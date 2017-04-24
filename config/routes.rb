Rails.application.routes.draw do
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]
  resources :subs
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
end
