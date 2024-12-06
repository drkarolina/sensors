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

ActiveRecord::Schema[7.1].define(version: 2024_12_05_033332) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sensor_data", force: :cascade do |t|
    t.integer "line1_total_in", null: false
    t.integer "line1_total_out", null: false
    t.integer "line1_period_in", null: false
    t.integer "line1_period_out", null: false
    t.decimal "location_occupancy_pct", null: false
    t.datetime "reported_at", null: false
    t.bigint "sensor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sensor_id"], name: "index_sensor_data_on_sensor_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.string "device", null: false
    t.integer "location_max_capacity", null: false
    t.string "external_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_sensors_on_external_id"
  end

  add_foreign_key "sensor_data", "sensors"
end
