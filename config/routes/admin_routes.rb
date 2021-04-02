scope path: 'admin', as: :admin do
  concerns :profile_section

  scope module: :admin do
    root to: 'dashboards#index'

    get '/dashboard', to: 'dashboards#index'

    resources :users do
      collection do
        resources :bulk, only: %i[new create show], as: :users_bulk_uploads, controller: 'users/bulk'
      end
    end
  end
end
