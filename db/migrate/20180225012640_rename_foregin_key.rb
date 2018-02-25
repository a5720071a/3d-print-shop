class RenameForeginKey < ActiveRecord::Migration[5.1]
  def change
    remove_reference :users, :user_groups, foreign_key: true
    add_reference :users, :user_group, foreign_key: true
    remove_reference :address_books, :users, foreign_key: true
    add_reference :address_books, :user, foreign_key: true
    remove_reference :models, :users, foreign_key: true
    add_reference :models, :user, foreign_key: true
    remove_reference :items, :models, foreign_key: true
    remove_reference :items, :filaments, foreign_key: true
    remove_reference :items, :print_speeds, foreign_key: true
    add_reference :items, :model, foreign_key: true
    add_reference :items, :filament, foreign_key: true
    add_reference :items, :print_speed, foreign_key: true
    remove_reference :carts, :users, foreign_key: true
    remove_reference :carts, :items, foreign_key: true
    add_reference :carts, :user, foreign_key: true
    add_reference :carts, :item, foreign_key: true
    remove_reference :orders, :users, foreign_key: true
    remove_reference :orders, :addresses, foreign_key: true
    add_reference :orders, :user, foreign_key: true
    add_reference :orders, :address, foreign_key: true
    remove_reference :payments, :orders, foreign_key: true
    add_reference :payments, :order, foreign_key: true
    remove_reference :items_in_orders, :orders, foreign_key: true
    remove_reference :items_in_orders, :items, foreign_key: true
    add_reference :items_in_orders, :order, foreign_key: true
    add_reference :items_in_orders, :item, foreign_key: true
    remove_reference :model_ratings, :users, foreign_key: true
    remove_reference :items, :users, foreign_key: true
    add_reference :model_ratings, :user, foreign_key: true
    add_reference :items, :user, foreign_key: true
  end
end
