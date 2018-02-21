class ManagementController < ApplicationController
  def manage
    @orders = Order.all
  end
end
