class CreatePrintSpeed < ActiveRecord::Migration[5.1]
  def change
    create_table :print_speeds do |t|
      t.string :configuration
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
