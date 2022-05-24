Rails.application.routes.draw do
  get '/', to: 'landing_page#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'

  get '/register', to: 'users#new'

  post '/users', to: 'users#create'

  get '/dashboard', to: 'users#show', as: :users_dashboard
  get '/movies/:id/viewing-party/new', to: 'parties#new'
  get '/movies/:id', to: 'movies#details'
  get '/movies', to: 'movies#results'
  get '/discover', to: 'movies#index'
  post '/movies/:id/viewing-party', to: 'parties#create'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    get 'users/:id', to: 'dashboard#show'
  end
end
