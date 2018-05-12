class RemovePrintSpeedFromItem < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :print_speed_id
  end
end
