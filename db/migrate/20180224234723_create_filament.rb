class CreateFilament < ActiveRecord::Migration[5.1]
  def change
    create_table :filaments do |t|
      t.string :description
      t.decimal :price_per_gram
      t.decimal :remaining
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
