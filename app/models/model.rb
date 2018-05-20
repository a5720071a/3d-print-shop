class Model < ApplicationRecord
  include ModelUploader::Attachment.new(:model)
  belongs_to :user
  has_many :gcodes
  has_many :items, through: :gcodes
  validates_inclusion_of :share, :in => [true, false]
end
