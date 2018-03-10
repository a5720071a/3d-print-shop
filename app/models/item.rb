class Item < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :model_id, presence: true
  validates :print_height, presence: true
  validates :print_width, presence: true
  validates :print_depth, presence: true
  validates :filament_id, presence: true
  validates :print_speed_id, presence: true
end
