class Order < ApplicationRecord
  include ModelUploader::Attachment.new(:model)
  validates :description, presence: true
end
