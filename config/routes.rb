Rails.application.routes.draw do
  get '/', to: 'landing_page#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/register', to: 'users#new'

  post '/users', to: 'users#create'

  get '/dashboard', to: 'users#show', as: :users_dashboard
  get '/users/:user_id/movies/:id/viewing-party/new', to: 'parties#new'
  get '/users/:user_id/movies/:id', to: 'movies#details'
  get '/users/:id/movies', to: 'movies#results'
  get '/users/:id/discover', to: 'movies#index'
  post '/users/:user_id/movies/:id/viewing-party', to: 'parties#create'

end
