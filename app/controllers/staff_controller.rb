class StaffController < ApplicationController
  before_action :require_user, :has_staff_privillege?
  def index
  end
end
