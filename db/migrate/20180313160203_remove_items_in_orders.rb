class RemoveItemsInOrders < ActiveRecord::Migration[5.1]
  def change
    drop_table :items_in_orders
  end
end
