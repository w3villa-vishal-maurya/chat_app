Rails.application.routes.draw do
  root 'chatroom#index'

  resources :users,only:[:new,:create]

  get 'login', to: 'session#new'
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'
  post 'message', to: 'message#create'
end
