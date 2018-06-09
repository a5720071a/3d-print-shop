class RenameAddressBookTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :address_books, :addresses
  end
end
