class ItemsController < ApplicationController
  before_action :require_user, :has_customer_privillege?
  protect_from_forgery with: :null_session
  def new
    @model = Model.find_by id: params[:model]
    @filaments = Filament.all
  end
  def create
    @item = Item.new(add_item_params)
    @item.user_id = @current_user.id
    if @item.save!
      Cart.create(user_id: @current_user.id, item_id: @item.id)
      redirect_to '/'
    else
      redirect_to controller: "items", action: "new", model: "#{ @upload.id }"
    end
  end
  private
  def add_item_params
    params.require(:item).permit(:model_id,:print_height,:print_width,:print_depth,:model_id,:filament_id,:print_speed_id)
  end
end
