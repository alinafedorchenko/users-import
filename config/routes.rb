require 'sidekiq/web'

Rails.application.routes.draw do
  root 'imports#index'

  resources :imports
  resources :import_processings, only: [:create]

  mount Sidekiq::Web => '/sidekiq'
end
