Rails.application.routes.draw do

  resources :games do
    get '/complete' => "games#complete"
  end
  post '/games/:token' => "games#update"
  root 'base#index'

  resources :sessions, :only => :create
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  resources :users
  get '/sign-up' => 'users#new', :as => 'signup'

end
