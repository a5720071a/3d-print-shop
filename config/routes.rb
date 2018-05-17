Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'

  get '/browse' => "models#index"
  get '/my_models' => "models#my_models"
  get '/upload' => 'models#new'
  post '/upload' => 'models#create'

  post '/thumbnailer' => 'items#thumbnailer'

  get '/print_settings' => 'items#new'
  post '/add_to_cart' => 'items#create'
  get '/my_cart' => 'items#my_cart'
  post '/calculate_price' => 'items#calculate_price'

  get '/my_orders' => 'orders#my_orders'
  get '/checkout' => 'orders#select_delivery_option'
  get '/confirm' => redirect('/checkout')
  post '/confirm' => 'orders#new'
  post '/order' => 'orders#create'
  post '/checkout' => 'payments#check'

  get '/payment_options' => 'payments#new'

  get '/new_address' => 'address_books#new'
  post '/create_address' => 'address_books#create'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/my_page' => 'users#show'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/staff' => 'staff#index'
  get '/staff/orders' => 'staff#orders'
  get '/staff/models' => 'staff#models'

  get '/admin' => 'admin#index'

  # for print jobs management
  post '/print_job_generated' => 'items#print_job_generated'
end
