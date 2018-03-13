class CreatePostalCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :postal_codes do |t|
      t.string :number_code
      t.string :city
      t.string :province
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
