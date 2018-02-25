class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_reference :users, :user_groups, foreign_key: true
  end
end
