class Order < ApplicationRecord
  belongs_to :user
  has_many :item_in_orders
  has_many :items, through: :item_in_orders
  has_one :payment
  [:user_id, :address_id, :delivery_courier].each do |field|
    validates field, presence: true
  end
end
