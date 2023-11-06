Rails.application.routes.draw do
  root "chatroom#index"

  resources :users, only: [:new, :create]

  get "login", to: "session#new"
  post "login", to: "session#create"
  delete "logout", to: "session#destroy"
  post "messages", to: "messages#create"

  mount ActionCable.server, at: "/cable"
end
