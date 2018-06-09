class RenameAddressColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :addresses, :address, :description
  end
end
