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

ActiveRecord::Schema.define(version: 20170418095351) do

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.string   "category_description"
    t.integer  "parent_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "product_price"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_status"
    t.integer  "order_cash"
    t.string   "order_receiving_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "product_name"
    t.text     "product_description"
    t.integer  "product_price"
    t.integer  "product_quantity"
    t.float    "product_rating_point"
    t.integer  "product_rating_times"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "rating_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_ratings_on_product_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "suggestings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "product_name"
    t.string   "product_image"
    t.integer  "product_price"
    t.text     "product_description"
    t.boolean  "suggesting_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_suggestings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "address"
    t.boolean  "gender"
    t.string   "phone"
    t.boolean  "is_admin"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "password_digest"
    t.index ["user_name", "email"], name: "index_users_on_user_name_and_email", unique: true
  end

end
