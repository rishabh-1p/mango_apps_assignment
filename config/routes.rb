Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/login', to: 'auth#create'
  resources :users
  resources :movies, only: [:create, :index, :show] do
    resources :showtimes, only: [:create, :index, :show] do
      # resources :bookings, only: [:create]
    end
  end
  get "/bookings", to: "bookings#index"
  post "showtime/:showtime_id/bookings", to: "bookings#create"
  delete "/bookings/:id", to: "bookings#destroy"
end
