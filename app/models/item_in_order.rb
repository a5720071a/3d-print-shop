class ItemInOrder < ApplicationRecord
  belongs_to :item
  belongs_to :order
  validates :quantity, presence: true
end
