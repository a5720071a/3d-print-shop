class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.text :model_data
      t.string :printing_material
      t.string :printing_speed
      t.string :printing_size
      t.string :delivery_method
      t.string :transaction_number
      t.timestamps
    end
  end
end
