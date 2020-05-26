# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_26_125919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appelations", force: :cascade do |t|
    t.bigint "region_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_appelations_on_region_id"
  end

  create_table "assemblages", force: :cascade do |t|
    t.integer "percentage"
    t.bigint "wine_id", null: false
    t.bigint "cepage_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cepage_id"], name: "index_assemblages_on_cepage_id"
    t.index ["wine_id"], name: "index_assemblages_on_wine_id"
  end

  create_table "bottles", force: :cascade do |t|
    t.bigint "wine_id", null: false
    t.bigint "cave_id", null: false
    t.integer "quantity"
    t.text "comment"
    t.date "apogee_start"
    t.date "apogee_end"
    t.string "liked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cave_id"], name: "index_bottles_on_cave_id"
    t.index ["wine_id"], name: "index_bottles_on_wine_id"
  end

  create_table "castles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "caves", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_caves_on_user_id"
  end

  create_table "cepages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wines", force: :cascade do |t|
    t.string "name"
    t.integer "millesime"
    t.date "apogee_start"
    t.date "apogee_end"
    t.string "color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "appelations", "regions"
  add_foreign_key "assemblages", "cepages"
  add_foreign_key "assemblages", "wines"
  add_foreign_key "bottles", "caves", column: "cave_id"
  add_foreign_key "bottles", "wines"
  add_foreign_key "caves", "users"
end
