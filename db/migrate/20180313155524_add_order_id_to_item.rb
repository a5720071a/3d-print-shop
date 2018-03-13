class AddOrderIdToItem < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :order, foreign_key: true
  end
end
