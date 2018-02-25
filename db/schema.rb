# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180225012640) do

  create_table "address_books", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_address_books_on_user_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "item_id"
    t.index ["item_id"], name: "index_carts_on_item_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "filaments", force: :cascade do |t|
    t.string "description"
    t.decimal "price_per_gram"
    t.decimal "remaining"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.decimal "print_height"
    t.decimal "print_width"
    t.decimal "print_depth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "model_id"
    t.integer "filament_id"
    t.integer "print_speed_id"
    t.integer "user_id"
    t.index ["filament_id"], name: "index_items_on_filament_id"
    t.index ["model_id"], name: "index_items_on_model_id"
    t.index ["print_speed_id"], name: "index_items_on_print_speed_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "items_in_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.integer "item_id"
    t.index ["item_id"], name: "index_items_in_orders_on_item_id"
    t.index ["order_id"], name: "index_items_in_orders_on_order_id"
  end

  create_table "model_ratings", force: :cascade do |t|
    t.string "comment"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_model_ratings_on_user_id"
  end

  create_table "models", force: :cascade do |t|
    t.text "model_data"
    t.boolean "share"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_models_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "delivery_courier"
    t.string "feedback_comment"
    t.integer "feedback_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "user_id"
    t.integer "address_id"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "service"
    t.string "transaction_number"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "print_speeds", force: :cascade do |t|
    t.string "configuration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.string "group_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_group_id"
    t.index ["user_group_id"], name: "index_users_on_user_group_id"
  end

end
