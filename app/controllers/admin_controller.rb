class AdminController < ApplicationController
  before_action :require_user, :has_admin_privillege?
  def index
  end
end
