class Item < ApplicationRecord
  belongs_to :user
  belongs_to :filament
  belongs_to :gcode
  [:user_id, :gcode_id, :scale, :print_height, :print_width, :print_depth, :filament_id, :price].each do |field|
    validates field, presence: true
  end
end
