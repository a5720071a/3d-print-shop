class AddGcodeToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :gcode, foreign_key: true
  end
end
