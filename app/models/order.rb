class Order < ApplicationRecord
  belongs_to :user
  include ModelUploader::Attachment.new(:model)
  validates :printing_material, presence: true
  validates :printing_speed, presence: true
  validates :printing_size, presence: true
  validates :delivery_method, presence: true
end
