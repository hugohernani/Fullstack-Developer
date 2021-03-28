class BasePresenter
  include Rails.application.routes.url_helpers

  protected

  def h
    ApplicationController.helpers
  end
end
