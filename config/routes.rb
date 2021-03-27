Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
  }

  unauthenticated do
    devise_scope :user do
      root to: 'devise/sessions#new'
    end
  end

  authenticated :user do
    root 'profiles#index', as: :authenticated_user
  end

  Pathname.new(Rails.root.join('config/routes/')).each_child do |route|
    instance_eval File.read route
  end
end
