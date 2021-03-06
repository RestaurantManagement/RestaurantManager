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

ActiveRecord::Schema.define(version: 20170322002820) do

  create_table "categories", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  create_table "info_staffs", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "nation"
    t.text     "description"
    t.string   "image"
    t.integer  "Staff_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["Staff_id", "created_at"], name: "index_info_staffs_on_staff_id_and_created_at"
    t.index ["Staff_id"], name: "index_info_staffs_on_Staff_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
    t.index ["category_id", "created_at"], name: "index_menu_items_on_category_id_and_created_at"
    t.index ["category_id"], name: "index_menu_items_on_category_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "menu_item_id"
    t.integer  "quantity"
    t.integer  "order_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["menu_item_id"], name: "index_order_items_on_menu_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "table_id"
    t.datetime "book_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "paid"
    t.index ["table_id"], name: "index_orders_on_table_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "raiting"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  create_table "tables", force: :cascade do |t|
    t.integer  "no"
    t.boolean  "beingUsed?"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["no"], name: "index_tables_on_no", unique: true
  end

  create_table "temp_order_items", force: :cascade do |t|
    t.integer  "menu_item_id"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "temp_order_id"
    t.index ["menu_item_id"], name: "index_temp_order_items_on_menu_item_id"
    t.index ["temp_order_id"], name: "index_temp_order_items_on_temp_order_id"
  end

  create_table "temp_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "book_time"
    t.index ["table_id"], name: "index_temp_orders_on_table_id"
    t.index ["user_id"], name: "index_temp_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
