class AddInCartFlagToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :in_cart_flag, :boolean
  end
end
