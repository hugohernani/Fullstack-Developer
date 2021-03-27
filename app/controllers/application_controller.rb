class ApplicationController < ActionController::Base
  before_action :protect_from_forgerry, with: :exception
  before_action :store_location!, if: :should_be_stored?

  private

  def store_location!
    store_location_for(:user, request.fullpath)
  end

  def should_be_stored?
    request.get? && is_navigation_format? &&
      !devise_controller? && !request.xhr?
  end
end
