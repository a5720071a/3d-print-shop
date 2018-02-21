class ManagementController < ApplicationController
  before_action :require_user
  def manage
    unless is_staff?(@current_user)
      redirect_to '/'
    else
      @orders = Order.all
    end
  end
  private
  def is_staff?(user)
    @current_user.usergroup == 'staff'
  end
end
