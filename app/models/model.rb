class Model < ApplicationRecord
  include ModelUploader::Attachment.new(:model)
  belongs_to :user
  validates_inclusion_of :share, :in => [true, false]
end
