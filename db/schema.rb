# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140101145113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "journeys", force: true do |t|
    t.datetime "started_at"
    t.datetime "ended_at"
    t.text     "original_description"
    t.string   "mode",                             null: false
    t.string   "bus_route"
    t.string   "start_name"
    t.string   "start_point",          limit: nil
    t.string   "end_name"
    t.string   "end_point",            limit: nil
    t.decimal  "distance"
    t.decimal  "speed"
    t.integer  "minutes_taken"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journeys", ["bus_route"], name: "index_journeys_on_bus_route", using: :btree
  add_index "journeys", ["distance"], name: "index_journeys_on_distance", using: :btree
  add_index "journeys", ["minutes_taken"], name: "index_journeys_on_minutes_taken", using: :btree
  add_index "journeys", ["mode"], name: "index_journeys_on_mode", using: :btree
  add_index "journeys", ["speed"], name: "index_journeys_on_speed", using: :btree
  add_index "journeys", ["started_at"], name: "index_journeys_on_started_at", unique: true, using: :btree

end
