class PrintSpeed < ApplicationRecord
  has_many :items
  validates :configuration, presence: true
end
