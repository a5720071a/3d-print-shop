class CartsController < ApplicationController
  before_action :require_user
  def my_cart
    @cart = Item.where(id: Cart.where(user_id: @current_user.id))
  end
end
