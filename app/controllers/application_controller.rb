class ApplicationController < ActionController::Base
  before_action :protect_from_forgerry, with: :exception
  before_action :store_location!, if: :should_be_stored?

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
