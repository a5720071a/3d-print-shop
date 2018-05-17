class StaffController < ApplicationController
  before_action :require_user, :has_staff_privillege?
  def index
  end
  def orders
    @orders = Order.all
  end
  def models
    @models = Model.all
  end
  # payment approval request
end
