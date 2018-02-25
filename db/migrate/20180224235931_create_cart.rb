class CreateCart < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_reference :carts, :users, foreign_key: true
    add_reference :carts, :items, foreign_key: true
  end
end
