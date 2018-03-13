class Order < ApplicationRecord
  belongs_to :user
  [:user_id, :address_id, :delivery_courier].each do |field|
    validates field, presence: true
  end
end
