class ManagementController < ApplicationController
  before_action :require_user
  def manage
    unless is_staff?(@current_user)
      redirect_to '/'
    else
      @orders = Order.all
    end
  end
  def show_order
    @order = Order.find_by id: params[:id]
    @user = User.find_by id: @order.user_id
    @order_info = { :id => @order.id, :by => @user.username }
  end
  private
  def is_staff?(user)
    @current_user.usergroup == 'staff'
  end
end
