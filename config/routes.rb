Dir.glob(Rails.root.join('config/route_concerns/**.rb')).each do |route_concern|
  require route_concern
end

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
  }

  as :user do
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  unauthenticated do
    devise_scope :user do
      root to: 'devise/sessions#new'
    end
  end

  authenticated :user do
    root 'profiles#show', as: :authenticated_user
  end

  instance_eval File.read Rails.root.join('config/routes/common_concerns.rb')
  Dir.glob(Rails.root.join('config/routes/*_routes.rb')).each do |route_path|
    instance_eval File.read route_path
  end
end
