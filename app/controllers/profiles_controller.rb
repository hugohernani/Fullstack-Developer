class ProfilesController < ApplicationController
  layout :role_based_layout

  before_action :authenticate_user!
  add_breadcrumb('Home', '/', root: true)
  add_breadcrumb('Profile', "/#{controller_path}")

  def show
    decorated_user
  end

  def edit
    decorated_user
  end

  def update
    respond_to do |format|
      if user.update(profile_params)
        format.html { redirect_to decorated_user.return_link, notice: t('.success') }
      else
        decorated_user
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def user
    @user ||= current_user
  end

  def decorated_user
    @user = ProfilePresenter.new(user, view_context: self)
  end

  def profile_params
    params.require(:user).permit(:full_name)
  end

  def role_based_layout
    return 'admin' if current_user.admin?

    'application'
  end
end
