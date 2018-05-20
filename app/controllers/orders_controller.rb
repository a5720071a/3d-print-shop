class OrdersController < ApplicationController
  before_action :require_user, :has_customer_privillege?
  before_action :has_item_in_cart?, except: :my_orders
  protect_from_forgery with: :null_session
  def select_delivery_option
    @addresses = @current_user.address_books
    @order = Order.new
  end
  def my_orders
    @orders = @current_user.orders.reverse
  end
  def new
    @order = Order.new(create_order_params)
    @delivery_info = %W(#{@current_user.username} #{AddressBook.find_by(id: @order.address_id).address} #{@order.delivery_courier})
    @items = @current_user.items.where in_cart: true
    @cart = @items.joins(:filament, :gcode).joins("LEFT JOIN models ON models.id = gcodes.model_id")
    @cart = @cart.select("items.*, filaments.description as f_description, models.id as m_id, models.model_data as m_model_data").reverse
  end
  def create
    @order = @current_user.orders.new(create_order_params)
    if @order.save!
      @items = @current_user.items.where in_cart: true
      [*@items].each do |item|
        item.in_cart = false
        item.save!
        item_in_order = ItemInOrder.new()
        item_in_order.item_id = item.id
        item_in_order.order_id = @order.id
        item_in_order.quantity = 1
        item_in_order.save!
      end
      redirect_to controller: "payments", action: "new", order: "#{ @order.id }"
    else
      redirect_to '/my_cart'
    end
  end
  private
  def create_order_params
    params.require(:order).permit(:delivery_courier,:address_id)
  end
end
