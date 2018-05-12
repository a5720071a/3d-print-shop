class AddPrintSpeedToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :print_speed, foreign_key: true
  end
end
