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

ActiveRecord::Schema.define(version: 2019_06_07_065440) do

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.string "type"
  end

  create_table "collections_products", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "collection_id"
    t.index ["collection_id"], name: "index_collections_products_on_collection_id"
    t.index ["product_id"], name: "index_collections_products_on_product_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "cost"
    t.integer "status", default: 0
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
  end

  create_table "suborders", force: :cascade do |t|
    t.integer "count"
    t.integer "variant_id"
    t.integer "order_id"
    t.integer "price"
    t.index ["order_id"], name: "index_suborders_on_order_id"
    t.index ["variant_id"], name: "index_suborders_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.string "name"
    t.integer "cost"
    t.integer "stock_amount"
    t.float "weight"
    t.integer "product_id"
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

end
