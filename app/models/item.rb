class Item < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
  belongs_to :filament
  belongs_to :print_speed
  belongs_to :model
  [:user_id, :model_id, :print_height, :print_width, :print_depth, :filament_id, :print_speed_id].each do |field|
    validates field, presence: true
  end
end
