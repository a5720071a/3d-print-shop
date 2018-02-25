class Model < ApplicationRecord
  belongs_to :user
  include ModelUploader::Attachment.new(:model)
  validates :share, presence: true
end
