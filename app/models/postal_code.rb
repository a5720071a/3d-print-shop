class PostalCode < ApplicationRecord
  [:number_code, :city, :province].each do |field|
    validates field, presence: true
  end
end
