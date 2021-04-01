module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    add_breadcrumb('Admin', '/admin/dashboard', root: true)

    layout 'admin'
  end
end
