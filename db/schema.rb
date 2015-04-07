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

ActiveRecord::Schema.define(version: 20150331123717) do

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.integer  "sport"
    t.integer  "variety"
    t.boolean  "poolgroupseason"
    t.string   "poolgroupseasonlabel"
    t.boolean  "playoffbracket"
    t.string   "playoffbracketlabel"
    t.boolean  "keepscores",              default: true
    t.integer  "winpoints"
    t.integer  "drawpoints"
    t.integer  "losspoints"
    t.integer  "forfeitpoints"
    t.integer  "forfeitwinscore"
    t.integer  "forfeitlossscore"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.string   "hashed_manager_password"
    t.string   "hashed_scorer_password"
    t.string   "salt"
  end

  create_table "contestants", force: true do |t|
    t.integer  "competition_id"
    t.string   "type"
    t.integer  "contest_id"
    t.string   "contest_type"
    t.string   "homeaway"
    t.integer  "team_id"
    t.integer  "score"
    t.boolean  "forfeit"
    t.string   "contestantcode"
    t.integer  "seeding"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests", force: true do |t|
    t.integer  "competition_id"
    t.string   "type"
    t.date     "date"
    t.integer  "time"
    t.integer  "venue_id"
    t.string   "status"
    t.integer  "homecontestant_id"
    t.integer  "awaycontestant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bracket_id"
    t.string   "name"
  end

  create_table "customers", force: true do |t|
    t.string   "userid"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "phone"
    t.string   "website"
  end

  create_table "groupings", force: true do |t|
    t.integer  "competition_id"
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bracket_grouping", default: false, null: false
  end

  create_table "teams", force: true do |t|
    t.integer  "competition_id"
    t.string   "name"
    t.integer  "grouping_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "validdates", force: true do |t|
    t.date     "gamedate"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: true do |t|
    t.string   "name"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "welcomes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
