Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'clients#home'
  get '/upload' => 'clients#upload'
  post '/upload' => 'clients#order'
  get '/browse' => 'clients#browse'
  get '/tutorial' => 'clients#tutorial'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  resources :orders
end
