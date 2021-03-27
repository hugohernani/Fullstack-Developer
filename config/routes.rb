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
end
