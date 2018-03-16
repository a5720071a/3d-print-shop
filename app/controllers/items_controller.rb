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
      unless File.exists?(create_thumb_path)
        uri = URI::Data.new(get_screenshot)
        File.open(create_thumb_path, 'wb') do |f|
          f.write(uri.data)
        end
      end
      redirect_to '/my_cart'
    else
      redirect_to controller: "items", action: "new", model: "#{ @upload.id }"
    end
  end
  def my_cart
    @items = @current_user.items.where(in_cart: true)
    @cart = @items.joins(:filament,:print_speed,:model)
    @cart = @cart.select("items.*, filaments.description as f_description, print_speeds.configuration as p_configuration, models.model_data as m_model_data")
  end
  private
  def add_item_params
    params.require(:item).permit(:model_id,:print_height,:print_width,:print_depth,:model_id,:filament_id,:print_speed_id)
  end
  def get_screenshot
    params.require(:item).permit(:screenshot)[:screenshot]
  end
  def create_thumb_path
    "public" + params.require(:item).permit(:model_url)[:model_url].split('.')[0] + ".png"
  end
end
