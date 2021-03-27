class BaseController < ApplicationController
  before_action :authenticated_user!
end
