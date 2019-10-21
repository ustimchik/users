Rails.application.routes.draw do
  devise_for :users

  root to: 'welcome#index'

  namespace :admin do
    resources :users do
      patch 'update_password', on: :collection
    end
    root to: 'users#index'
  end
end
