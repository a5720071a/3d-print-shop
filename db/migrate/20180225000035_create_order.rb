class CreateOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :delivery_courier
      t.string :feedback_comment
      t.integer :feedback_score
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_reference :orders, :users, foreign_key: true
    add_reference :orders, :addresses, foreign_key: true
  end
end
