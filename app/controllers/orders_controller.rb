class OrdersController < ApplicationController
  before_action :require_user, :has_customer_privillege?
  protect_from_forgery with: :null_session
  def select_delivery_option
    @addresses = @current_user.address_books
    @order = Order.new
  end
  def index
    @orders = @current_user.orders
    @item_lists = []
    [*@orders].each do |order|
      @item_lists.push ItemsInOrder.where order_id: order.id
    end
  end
  def new
    @order = Order.new(select_delivery_params)
    @delivery_info = %W(#{@current_user.username} #{AddressBook.find_by(id: @order.address_id).address} #{@order.delivery_courier})
    @items = @current_user.items.where in_cart: true
  end
  def create
    @order = @current_user.orders.new(create_order_params)
    if @order.save!
      @items = @current_user.items.where in_cart: true
      [*@items].each do |item|
        ItemsInOrder.create order_id: @order.id, item_id: item.id
        item.in_cart = false
        item.save!
      end
      redirect_to '/payment_options'
    else
      redirect_to '/my_cart'
    end
  end
  private
  def create_order_params
    params.require(:order).permit(:delivery_courier,:address_id)
  end
  def select_delivery_params
    params.require(:order).permit(:delivery_courier,:address_id)
  end
end
