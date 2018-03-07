Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'

  get '/browse' => "models#index"
  get '/my_models' => "models#my_models"
  get '/upload' => 'models#new'
  post '/upload' => 'models#create'

  get '/print_settings' => 'orders#new'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/staff' => 'staff#index'

  get '/admin' => 'admin#index'

end
