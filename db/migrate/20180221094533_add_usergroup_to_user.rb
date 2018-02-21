class AddUsergroupToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :usergroup, :string
  end
end
