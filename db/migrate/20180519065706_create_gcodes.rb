class CreateGcodes < ActiveRecord::Migration[5.1]
  def change
    create_table :gcodes do |t|
      t.references :model, foreign_key: true
      t.string :filename
      t.decimal :filament_length
      t.decimal :print_time

      t.timestamps
    end
  end
end
