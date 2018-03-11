class ItemsController < ApplicationController
  before_action :require_user, :has_customer_privillege?
  protect_from_forgery with: :null_session
  def new
    @item = Item.new
    @model = Model.find_by id: params[:model]
    @filaments = Filament.all
  end
  def create
    @item = @current_user.items.new(add_item_params)
    @item.in_cart = "true"
    if @item.save!
      redirect_to '/my_cart'
    else
      redirect_to controller: "items", action: "new", model: "#{ @upload.id }"
    end
  end
  def my_cart
    @items = @current_user.items.where in_cart: true
  end
  private
  def add_item_params
    params.require(:item).permit(:model_id,:print_height,:print_width,:print_depth,:model_id,:filament_id,:print_speed_id)
  end
end
