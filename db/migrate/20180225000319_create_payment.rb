class CreatePayment < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :service
      t.string :transaction_number
      t.string :status
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_reference :payments, :orders, foreign_key: true
    add_column :orders, :status, :string
  end
end
