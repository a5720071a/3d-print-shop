class Model < ApplicationRecord
  include ModelUploader::Attachment.new(:model)
  belongs_to :user
  has_many :items
  has_many :gcodes
  validates_inclusion_of :share, :in => [true, false]
end
