class ClientsController < ApplicationController
  before_action :require_user, except: [:home]
  protect_from_forgery with: :null_session
  def home; end
  def upload
    @order = Order.new
  end
  def order
    @order = Order.new(order_params)
    @order.printing_material = "abs_white"
    @order.printing_size = "100%"
    @order.printing_speed = "regular"
    @order.delivery_method = "regular"
    @order.user_id = @current_user.id
    if @order.save
      redirect_to action: "preview", order: "#{ @order.id }"
    else
      redirect_to '/upload'
    end
  end
  def preview
    @order = Order.find_by_id(params[:order])
  end
  def orders
    @orders = Order.where user_id: @current_user.id
  end
  def show_order
    @order = Order.find_by_id(params[:id])
  end
  def browse; end
  def tutorial; end
  private
  def order_params
    params.require(:order).permit(:model)
  end
end
