class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.text :model_data
      t.text :description
      t.timestamps
    end
  end
end
