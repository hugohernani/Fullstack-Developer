scope path: 'admin', as: :admin do
  concerns :profile_section

  scope module: :admin do
    root to: 'dashboards#index'

    get '/dashboard', to: 'dashboards#index'

    resources :users
  end
end
