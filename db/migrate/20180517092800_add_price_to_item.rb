class AddPriceToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :price, :decimal
  end
end
