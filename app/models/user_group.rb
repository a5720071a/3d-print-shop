class UserGroup < ApplicationRecord
  validates :group_name, presence: true
end
