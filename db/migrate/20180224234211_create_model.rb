class CreateModel < ActiveRecord::Migration[5.1]
  def change
    create_table :models do |t|
      t.text :model_data
      t.boolean :share
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_reference :models, :users, foreign_key: true
  end
end
