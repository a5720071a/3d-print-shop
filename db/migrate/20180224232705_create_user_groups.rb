class CreateUserGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_groups do |t|
      t.string :group_name
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
