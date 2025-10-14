# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_12_030122) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "critter_availabilities", force: :cascade do |t|
    t.integer "critter_id", null: false
    t.string "hemisphere", null: false
    t.integer "start_minute"
    t.integer "end_minute"
    t.boolean "all_day", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "month", null: false
    t.index ["critter_id"], name: "index_critter_availabilities_on_critter_id"
  end

  create_table "critters", force: :cascade do |t|
    t.string "name", null: false
    t.integer "sell_price", null: false
    t.string "furniture_size"
    t.boolean "furniture_has_surface", null: false
    t.text "description", null: false
    t.string "catch_phrase", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "spawn_location"
    t.string "spawn_weather"
    t.integer "catches_to_unlock", null: false
    t.string "shadow_size"
    t.string "catch_difficulty"
    t.string "visual_width"
    t.string "movement_speed"
    t.string "type"
    t.string "entry_id", null: false
    t.index ["entry_id"], name: "index_critters_on_entry_id", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "critter_availabilities", "critters"
  add_foreign_key "sessions", "users"
end
