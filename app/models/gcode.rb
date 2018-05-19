class Gcode < ApplicationRecord
  belongs_to :model
  [:filename, :filament_length, :print_time].each do |field|
    validates field, presence: true
  end
end
