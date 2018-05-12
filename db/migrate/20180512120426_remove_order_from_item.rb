class RemoveOrderFromItem < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :order_id
  end
end
