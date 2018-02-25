class DropAllTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :users
    drop_table :orders
  end
end
