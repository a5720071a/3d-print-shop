class CreateRelationItemOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :items_in_orders do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_reference :items_in_orders, :orders, foreign_key: true
    add_reference :items_in_orders, :items, foreign_key: true
  end
end
