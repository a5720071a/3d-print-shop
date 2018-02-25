class CreateAddressBook < ActiveRecord::Migration[5.1]
  def change
    create_table :address_books do |t|
      t.string :address
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_reference :address_books, :users, foreign_key: true
  end
end
