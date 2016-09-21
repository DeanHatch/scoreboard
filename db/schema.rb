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

ActiveRecord::Schema.define(version: 20160913215223) do

  create_table "alert_requests", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.string   "to_dest",    limit: 255
    t.string   "at_domain",  limit: 255
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alert_requests", ["team_id"], name: "index_alert_requests_on_team_id"

  create_table "bcadvancements", force: :cascade do |t|
    t.integer  "from_contest_id"
    t.string   "wl",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competitions", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.integer  "sport"
    t.integer  "variety"
    t.boolean  "poolgroupseason"
    t.string   "poolgroupseasonlabel",    limit: 255
    t.boolean  "playoffbracket"
    t.string   "playoffbracketlabel",     limit: 255
    t.boolean  "keepscores",                          default: true
    t.integer  "winpoints"
    t.integer  "drawpoints"
    t.integer  "losspoints"
    t.integer  "forfeitpoints"
    t.integer  "forfeitwinscore"
    t.integer  "forfeitlossscore"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.string   "hashed_manager_password", limit: 255
    t.string   "hashed_scorer_password",  limit: 255
    t.string   "salt",                    limit: 255
  end

  create_table "contestants", force: :cascade do |t|
    t.integer  "competition_id"
    t.string   "type",               limit: 255
    t.integer  "contest_id"
    t.string   "contest_type",       limit: 255
    t.string   "homeaway",           limit: 255
    t.integer  "team_id"
    t.integer  "score"
    t.boolean  "forfeit"
    t.integer  "seeding"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bracketgrouping_id"
    t.string   "bcspec_type",        limit: 255
    t.integer  "bcspec_id"
  end

  create_table "contests", force: :cascade do |t|
    t.integer  "competition_id"
    t.string   "type",               limit: 255
    t.date     "date"
    t.integer  "time"
    t.integer  "venue_id"
    t.string   "status",             limit: 255
    t.integer  "homecontestant_id"
    t.integer  "awaycontestant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bracketgrouping_id"
    t.string   "name",               limit: 255
  end

  create_table "credits", force: :cascade do |t|
    t.string   "type"
    t.integer  "customer_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "customers", ["confirmation_token"], name: "index_customers_on_confirmation_token", unique: true
  add_index "customers", ["email"], name: "index_customers_on_email", unique: true
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  add_index "customers", ["unlock_token"], name: "index_customers_on_unlock_token", unique: true

  create_table "groupingplaces", force: :cascade do |t|
    t.integer  "grouping_id"
    t.integer  "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groupings", force: :cascade do |t|
    t.integer  "competition_id"
    t.string   "name",             limit: 255
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bracket_grouping",             default: false, null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.string   "phone",       limit: 255
    t.string   "website",     limit: 255
    t.integer  "customer_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "competition_id"
    t.string   "name",           limit: 255
    t.integer  "grouping_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "valid_times", force: :cascade do |t|
    t.integer  "competition_id"
    t.integer  "grouping_id"
    t.integer  "venue_id"
    t.integer  "from_time"
    t.integer  "to_time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "validdates", force: :cascade do |t|
    t.date     "gamedate"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "welcomes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
