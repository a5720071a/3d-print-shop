class RemoveModelFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_reference :items, :model, foreign_key: true
  end
end
