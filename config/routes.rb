Rails.application.routes.draw do
  
  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  resources :users
  resources :sessions
  resources :items
  resources :item_prices

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'insights' => 'home#admin_insights', :as => :admin_insights
  get 'actions' => 'home#admin_actions', :as => :admin_actions
  get 'welcome' => 'home#customer_home', :as => :customer_home
  get 'baker_home' => 'home#baker_home', :as => :baker_home
  get 'shipper_home' => 'home#shipper_home', :as => :shipper_home


  get 'registered' => 'sessions#create', :as => :create_session

  get 'add_to_cart' => 'orders#add_to_cart', :as => :add_to_cart
  get 'remove_from_cart' => 'orders#remove_from_cart', :as => :remove_from_cart

  get 'toggle_shipped' => 'order_items#toggle_shipped', :as => :toggle_shipped

  get 'toggle_item_state' => 'items#toggle_item_state', :as => :toggle_item_state
  get 'toggle_customer_state' => 'customers#toggle_customer_state', :as => :toggle_customer_state
  get 'toggle_address_state' => 'addresses#toggle_address_state', :as => :toggle_address_state
  
  # Set the root url
  root :to => 'home#home'

  # Searching
  get 'home/search', to: 'home#search', as: :search
  
end
