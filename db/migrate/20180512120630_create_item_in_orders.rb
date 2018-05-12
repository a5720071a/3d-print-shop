class CreateItemInOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :item_in_orders do |t|
      t.references :order
      t.references :item
      t.integer :quantity

      t.timestamps
    end
  end
end
