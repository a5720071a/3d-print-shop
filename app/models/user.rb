class User < ApplicationRecord
  has_many :orders
  has_secure_password
  validates :email, presence: true
  validates :username, presence: true
  validates :password, presence: true
end
