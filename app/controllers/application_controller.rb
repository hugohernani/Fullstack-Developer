class ApplicationController < ActionController::Base
  include Breadcrumbs
  protect_from_forgery with: :exception

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

  def role_landing_page(resource)
    RoleLandingService.perform(resource: resource, context: self)
  end
end
