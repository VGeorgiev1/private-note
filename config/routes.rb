Rails.application.routes.draw do
  resources :users
  resources :notes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  post '/sent' => 'notes#new'
  get '/view/:id' => 'notes#view'
  post '/register' => 'users#new'
  get '/login' => 'users#loginGet'
  post '/login' => 'users#loginPost'
end
