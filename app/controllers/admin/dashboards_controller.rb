module Admin
  class DashboardsController < BaseController
    add_breadcrumb 'Dashboard', '/admin/dashboard'

    def index
      authorize :dashboard
      @dashboard = UserQuery.new.search
    end
  end
end
