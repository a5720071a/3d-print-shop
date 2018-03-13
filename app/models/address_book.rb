class AddressBook < ApplicationRecord
  belongs_to :user
  [:user_id, :address].each do |field|
    validates field, presence: true
  end
end
