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
    @cart = @items.joins(:filament, :gcode).joins("LEFT JOIN models ON models.id = gcodes.model_id")
    @cart = @cart.select("items.*, filaments.description as f_description, models.id as m_id, models.model_data as m_model_data").reverse
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
    @gcode_params = get_gcode_params
    @model_id = @gcode_params[0]
    @model = Model.find_by id: @model_id
    @scale = @gcode_params[1]
    @filament_type = @gcode_params[2]
    @stl_path = './public' + @model.model_url
    @gcode_path = './public/gcodes/' + @model.model_url.split('/')[-1].split('.')[0] + '_' + @scale + '.g'
    unless Gcode.exists?(model_id: @model_id, filename: @gcode_path)
      @work = Thread.new do
        Rails.application.executor.wrap do
          unless File.exists?(@gcode_path)
            @gcode_gen =  `slic3r --load ~/Downloads/config.ini --scale #{@scale} --print-center 0x0 --support-material #{@stl_path} -o #{@gcode_path}`
          end
          @result = `python2.7 ~/Downloads/gcoder.py #{@gcode_path}`
          @filament_used = @result.split("\n")[-4].split(":\ ",2)[-1].gsub(/[^0-9,\.]/, "").to_f
          @total_time = @result.split("\n")[-1].split(":\ ",2)[-1]
          if @total_time.include? "day"
            @hour = @total_time.split('day')[0].gsub(/[^\d]/,"").to_i * 24
            @hour += @total_time.split('day')[1].split(':')[0].gsub(/[^\d]/,"").to_i
            @hour += ((@total_time.split('day')[1].split(':')[1].to_i + 1) / 60.0)
          else
            @hour = @total_time.split(':')[0].to_i
            @hour += ((@total_time.split(':')[1].to_i + 1)/ 60.0)
          end
          @gcode = @model.gcodes.new(filename: @gcode_path, print_time: @hour.round(3), filament_length: @filament_used)
          @gcode.save!
        end
      end
      @work.join
    else
      @gcode = Gcode.find_by model_id: @model_id, filename: @gcode_path
    end
    @price = @gcode.print_time.round(3) * 5.33673058261
    @price += ((Math::PI * ((0.17 / 2) ** 2) * (@gcode.filament_length/10) * 1.25) * 0.95) if @filament_type.include? "PLA"
    @price += ((Math::PI * ((0.17 / 2) ** 2) * (@gcode.filament_length/10) * 1.04) * 0.90) if @filament_type.include? "ABS"
    @price += 105
    @price = @price.round(2) * 2
    respond_to do |format|
      format.js
    end
  end
  private
  def add_item_params
    params.require(:item).permit(:scale, :print_height, :print_width, :print_depth, :filament_id, :price, :gcode_id)
  end
  def get_model_screenshot
    params.require(:item).permit(:screenshot)[:screenshot]
  end
  def get_item_screenshot
    params.require(:item).permit(:finished_item)[:finished_item]
  end
  def create_model_thumb_path
    "public" + params[:model_url].split('.')[0] + ".png"
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
  def get_gcode_params
    [params[:model_id],params[:scale],params[:filament]]
  end
end
