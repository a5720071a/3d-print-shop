class ClientsController < ApplicationController
  before_action :require_user, only: [:upload]
  
  protect_from_forgery with: :null_session
  def home
  end
  def upload
    @order = Order.new
  end
  def order
    @order = Order.new(order_params)
    if @order.save
      redirect_to '/'
    else
      redirect_to '/404.html'
    end
  end
  def browse
  end
  def tutorial
  end
  private
    def order_params
      params.require(:order).permit(:model, :description)
    end
end
