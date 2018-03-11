class Filament < ApplicationRecord
  [:description, :price_per_gram, :remaining, :hex_color_value].each do |field|
    validates field, presence: true
  end
end
