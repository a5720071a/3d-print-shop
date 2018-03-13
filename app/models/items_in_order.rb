class ItemsInOrder < ApplicationRecord
  belongs_to :order
  belongs_to :item
  [:order_id, :item_id].each do |field|
    validates field, presence: true
  end
end
