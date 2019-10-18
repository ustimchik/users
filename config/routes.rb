Rails.application.routes.draw do
  devise_for :users

  root to: 'welcome#index'

  namespace :admin do
    resources :users
    root to: 'users#index'
  end
end
