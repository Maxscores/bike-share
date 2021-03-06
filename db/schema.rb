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

ActiveRecord::Schema.define(version: 20171205215806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.date  "date"
    t.float "max_temperature_f"
    t.float "mean_temperature_f"
    t.float "min_temperature_f"
    t.float "mean_humidity"
    t.float "mean_visibility_miles"
    t.float "mean_wind_speed_mph"
    t.float "precipitation_inches"
  end

  create_table "stations", force: :cascade do |t|
    t.string  "name"
    t.integer "dock_count"
    t.string  "city"
    t.date    "installation_date"
    t.float   "latitude"
    t.float   "longitude"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.date "start_date"
    t.string "start_station_name"
    t.date "end_date"
    t.string "end_station_name"
    t.integer "bike_id"
    t.string  "subscription_type"
    t.integer "zipcode"
    t.integer "start_station_id"
    t.integer "end_station_id"
    t.integer "condition_id"
  end

end
