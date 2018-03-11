class RemoveCart < ActiveRecord::Migration[5.1]
  def change
    drop_table :carts
  end
end
