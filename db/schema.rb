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

ActiveRecord::Schema.define(version: 20150111022712) do

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.integer  "sport"
    t.integer  "variety"
    t.boolean  "poolgroupseason"
    t.boolean  "keepscores"
    t.integer  "winpoints"
    t.integer  "drawpoints"
    t.integer  "losspoints"
    t.integer  "forfeitpoints"
    t.integer  "forfeitwinscore"
    t.integer  "forfeitlossscore"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "playoffbracket"
    t.string   "poolgroupseasonlabel"
    t.string   "playoffbracketlabel"
  end

  create_table "contestants", force: true do |t|
    t.integer  "contest_id"
    t.string   "contest_type"
    t.string   "homeaway"
    t.integer  "team_id"
    t.integer  "score"
    t.boolean  "forfeit"
    t.string   "contestanttype"
    t.integer  "seeding"
    t.integer  "bracketcontest_id"
    t.integer  "grouping_id"
    t.integer  "place"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "contestants", ["bracketcontest_id"], name: "index_contestants_on_bracketcontest_id"
  add_index "contestants", ["contest_id", "contest_type"], name: "index_contestants_on_contest_id_and_contest_type"
  add_index "contestants", ["grouping_id"], name: "index_contestants_on_grouping_id"
  add_index "contestants", ["team_id"], name: "index_contestants_on_team_id"

  create_table "contests", force: true do |t|
    t.date     "date"
    t.time     "time"
    t.integer  "venue_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "homecontestant_id"
    t.integer  "awaycontestant_id"
    t.string   "type"
  end

  create_table "groupings", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "grouping_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "validdates", force: true do |t|
    t.date     "gamedate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
