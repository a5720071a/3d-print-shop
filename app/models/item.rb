class Item < ApplicationRecord
  belongs_to :user
  belongs_to :filament
  belongs_to :model
  [:user_id, :model_id, :scale, :print_height, :print_width, :print_depth, :filament_id].each do |field|
    validates field, presence: true
  end
end
