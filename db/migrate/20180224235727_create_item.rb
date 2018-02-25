class CreateItem < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.decimal :print_height
      t.decimal :print_width
      t.decimal :print_depth
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_reference :items, :models, foreign_key: true
    add_reference :items, :filaments, foreign_key: true
    add_reference :items, :print_speeds, foreign_key: true
  end
end
