class ItemsController < ApplicationController
  before_action :require_user, :has_customer_privillege?, except: :print_job_generated
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
      unless File.exists?(create_model_thumb_path)
        uri = URI::Data.new(get_model_screenshot)
        File.open(create_model_thumb_path, 'wb') do |f|
          f.write(uri.data)
        end
      end
      uri = URI::Data.new(get_item_screenshot)
      File.open(create_item_thumb_path(String(@item.id)), 'wb') do |f|
        f.write(uri.data)
      end
      redirect_to '/my_cart'
    else
      redirect_to controller: "items", action: "new", model: "#{ @upload.id }"
    end
  end
  def my_cart
    @items = @current_user.items.where in_cart: true
    @cart = @items.joins :filament,:model
    @cart = @cart.select("items.*, filaments.description as f_description, models.model_data as m_model_data")
  end
  def thumbnailer
    unless File.exists?(ajax_create_model_thumb_path)
      uri = URI::Data.new(ajax_get_screenshot)
      File.open(ajax_create_model_thumb_path, 'wb') do |f|
        f.write(uri.data)
      end
    end
  end
  def print_job_generated
    @item = Item.find_by id: print_job_for_item
    @item.print_job_generated = "true"
    if @item.save
      render :plain=> "Ok"
    else
      render :plain => "Error"
    end
  end
  def calculate_price
    @gcode_gen = `slic3r --load ~/Downloads/config.ini --scale 0.933 --print-center 0x0 ~/Downloads/owl.stl -o ~/owl.g`
    @result = `python2.7 ~/Downloads/gcoder.py ~/owl.g`
    respond_to do |format|
      format.js
    end
  end
  private
  def add_item_params
    params.require(:item).permit(:model_id,:scale,:print_height,:print_width,:print_depth,:model_id,:filament_id)
  end
  def get_model_screenshot
    params.require(:item).permit(:screenshot)[:screenshot]
  end
  def get_item_screenshot
    params.require(:item).permit(:finished_item)[:finished_item]
  end
  def create_model_thumb_path
    "public" + params.require(:item).permit(:model_url)[:model_url].split('.')[0] + ".png"
  end
  def ajax_create_model_thumb_path
    "public" + params.require(:model_url).split('.')[0] + ".png"
  end
  def ajax_get_screenshot
    params.require(:screenshot)
  end
  def create_item_thumb_path(id)
    "public/items/" + id + ".png"
  end
  def print_job_for_item
    params[:item_id]
  end
end
