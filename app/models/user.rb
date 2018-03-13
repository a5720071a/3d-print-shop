class User < ApplicationRecord
  has_secure_password
  has_many :models
  has_many :items
  has_many :orders
  has_many :address_books
  [:email, :username].each do |field|
    validates field, presence: true, uniqueness: true
  end
  validates :password, presence: true
end
