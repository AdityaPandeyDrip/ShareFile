Rails.application.routes.draw do
  get '/signup' => 'user#new'
  post '/user/create' => 'user#create'
  get '/' => 'user#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  post 'file/attach' => 'file#attach'
  delete 'file/delete' => 'file#delete'

  get 'share/new' => 'share#new'
  post 'share/create' => 'share#create'
  delete 'share/delete' => 'share#delete'
end