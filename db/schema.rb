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

ActiveRecord::Schema.define(version: 2021_10_24_080918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discounts", force: :cascade do |t|
    t.string "type", null: false
    t.integer "purchase_item_quantity"
    t.integer "free_item_quantity"
    t.integer "percent_discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_discounts", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "discount_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_id"], name: "index_item_discounts_on_discount_id"
    t.index ["item_id"], name: "index_item_discounts_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.decimal "price", precision: 5, scale: 2, null: false
    t.uuid "gid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_items_on_code", unique: true
  end

end
