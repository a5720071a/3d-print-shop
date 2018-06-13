class Item < ApplicationRecord
  belongs_to :user
  belongs_to :filament
  belongs_to :gcode
  has_one :item_in_order
  [:user_id, :gcode_id, :scale, :print_height, :print_width, :print_depth, :filament_id, :price].each do |field|
    validates field, presence: true
  end
  delegate :order, to: :item_in_order, allow_nil: true
end
