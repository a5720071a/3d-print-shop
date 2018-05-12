class AddScaleToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :scale, :decimal
  end
end
