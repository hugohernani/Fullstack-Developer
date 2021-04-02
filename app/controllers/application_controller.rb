class ApplicationController < ActionController::Base
  include BreadcrumbsCollectable
  protect_from_forgery with: :exception
  add_flash_types :success, :error

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :account_not_authorized

  protected

  def after_sign_up_path_for(resource)
    role_landing_page(resource)
  end

  def after_sign_in_path_for(resource)
    role_landing_page(resource)
  end

  def after_sign_out_path_for(_resource)
    root_path
  end

  private

  def account_not_authorized
    redirect_to(request.referer || role_landing_page(current_user), error: t('base.not_authorized'))
  end

  def role_landing_page(resource)
    RoleLandingService.perform(resource: resource, context: self)
  end
end
