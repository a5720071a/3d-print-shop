class CreateModelRating < ActiveRecord::Migration[5.1]
  def change
    create_table :model_ratings do |t|
      t.string :comment
      t.integer :score
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_reference :model_ratings, :users, foreign_key: true
    add_reference :items, :users, foreign_key: true
  end
end
