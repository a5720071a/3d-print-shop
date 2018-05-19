class PaymentsController < ApplicationController
  before_action :require_user, :has_customer_privillege?
  protect_from_forgery with: :null_session
  def new
    @order = Order.find_by id: params[:order]
    if @order.user != @current_user
      redirect_to root_path
    elsif not @order.payment.nil? and @order.payment.status == "Success"
      redirect_to my_orders_path
    end
    @items = @order.items
    @price = 0
    @items.each do |item|
      @price += item.price
    end
    @total = @price.to_s
    if @total.include? '.'
      @total = @total.split('.')[0] + @total.split('.')[-1]
      @total += '0' if @price.to_s.split('.')[-1].length == 1
    else
      @total += '00'
    end
  end
  def check
    @order = Order.find_by id: get_order_id
    @items = @order.items
    @price = 0
    @items.each do |item|
      @price += item.price
    end
    @total = @price.to_s.gsub(/\./,"").to_i
    charge = Omise::Charge.create({
      amount: @total,
      currency: "thb",
      card: params[:omiseToken]
    })
    if charge.paid
      # handle success
      if not Payment.exists?(order: @order)
        @payment = Payment.new(order: @order, service: "Omise", transaction_number: params[:omiseToken], status: "Success")
        @payment.save
      end
      @result = 'success'
    else
      # handle failure
      @result = charge.failure_code
    end
  end
  private
  def get_order_id
    params[:order_id]
  end
end
