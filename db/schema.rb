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

ActiveRecord::Schema.define(version: 20180112211430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "category_groups", force: :cascade do |t|
    t.bigint "item_type_id"
    t.bigint "medium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type_id"], name: "index_category_groups_on_item_type_id"
    t.index ["medium_id"], name: "index_category_groups_on_medium_id"
  end

  create_table "field_groups", force: :cascade do |t|
    t.bigint "item_field_id"
    t.bigint "medium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_field_id"], name: "index_field_groups_on_item_field_id"
    t.index ["medium_id"], name: "index_field_groups_on_medium_id"
  end

  create_table "item_fields", force: :cascade do |t|
    t.string "field_type"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_values", force: :cascade do |t|
    t.string "name"
    t.bigint "item_field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_field_id"], name: "index_item_values_on_item_field_id"
  end

  create_table "media", force: :cascade do |t|
    t.string "medium"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "substrate_types", force: :cascade do |t|
    t.bigint "item_type_id"
    t.bigint "substrate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type_id"], name: "index_substrate_types_on_item_type_id"
    t.index ["substrate_id"], name: "index_substrate_types_on_substrate_id"
  end

  create_table "substrates", force: :cascade do |t|
    t.string "substrate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "category_groups", "item_types"
  add_foreign_key "category_groups", "media"
  add_foreign_key "field_groups", "item_fields"
  add_foreign_key "field_groups", "media"
  add_foreign_key "item_values", "item_fields"
  add_foreign_key "substrate_types", "item_types"
  add_foreign_key "substrate_types", "substrates"
end
