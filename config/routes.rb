Rails.application.routes.draw do
  
  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  resources :users
  resources :sessions
  resources :items

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'insights' => 'home#admin_insights', :as => :admin_insights
  get 'welcome' => 'home#customer_home', :as => :customer_home
  get 'actions' => 'home#admin_actions', :as => :admin_actions
  get 'registered' => 'sessions#create', :as => :create_session
  
  
  # Set the root url
  root :to => 'home#home'

  # Searching
  get 'home/search', to: 'home#search', as: :search
  
end
