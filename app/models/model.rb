class Model < ApplicationRecord
  belongs_to :user
  include ModelUploader::Attachment.new(:model)
  validates_inclusion_of :share, :in => [true, false]
end
