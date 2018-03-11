class Model < ApplicationRecord
  include ModelUploader::Attachment.new(:model)
  belongs_to :user
  validates :share, inclusion: { in: %w(true false)  }
end
