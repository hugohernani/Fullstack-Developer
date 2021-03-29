namespace :admin do
  root to: 'dashboards#index'

  get '/dashboard', to: 'dashboards#index'

  resources :users
end
