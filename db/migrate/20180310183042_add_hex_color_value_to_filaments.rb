class AddHexColorValueToFilaments < ActiveRecord::Migration[5.1]
  def change
    add_column :filaments, :hex_color_value, :string
  end
end
