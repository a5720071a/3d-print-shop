class User < ApplicationRecord
  has_many :models
  has_many :items
  has_many :carts
  has_many :orders
  has_many :addresses
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
