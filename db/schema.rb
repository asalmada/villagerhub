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

ActiveRecord::Schema[8.0].define(version: 2025_10_10_194051) do
  create_table "critter_availabilities", force: :cascade do |t|
    t.integer "critter_id", null: false
    t.string "hemisphere"
    t.text "months_json", null: false
    t.integer "start_minute"
    t.integer "end_minute"
    t.boolean "all_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["critter_id"], name: "index_critter_availabilities_on_critter_id"
  end

  create_table "critters", force: :cascade do |t|
    t.string "name"
    t.integer "sell_price"
    t.integer "furniture_size"
    t.boolean "furniture_has_surface"
    t.text "description"
    t.string "catch_phrase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "spawn_location"
    t.string "spawn_weather"
    t.integer "catches_to_unlock"
    t.string "shadow_size"
    t.string "catch_difficulty"
    t.string "visual_width"
    t.string "movement_speed"
    t.string "type"
  end

  add_foreign_key "critter_availabilities", "critters"
end
