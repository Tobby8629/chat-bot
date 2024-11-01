require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
    
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "pages#welcome"
  get "home", to:"pages#home", as:"home"
  get "chat/:id", to:"chat#show", as:"chat"
  post "send_message", to: "chat#send_message", as: "send_message"
  post "send_message_to_chat/:id", to: "chat#send_message_to_chat", as: "send_message_to_chat"
  delete "delete_chat/:id", to: "chat#delete_chat", as: "delete_chat"

end
