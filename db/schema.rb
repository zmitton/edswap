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

ActiveRecord::Schema.define(version: 20160111180137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listing_images", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "precedence"
    t.string   "image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "active"
    t.string   "zip"
    t.string   "bay_area"
    t.boolean  "buying"
    t.boolean  "selling"
    t.boolean  "lending"
    t.boolean  "trading"
    t.boolean  "borrowing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string  "locationeable_type"
    t.integer "locationeable_id"
    t.string  "school_name"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "bay_area"
    t.string  "x_coord"
    t.string  "y_coord"
  end

  create_table "temp_email_addresses", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "real_email_address"
    t.uuid     "temp_email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "temp_email_addresses", ["listing_id"], name: "index_temp_email_addresses_on_listing_id", using: :btree
  add_index "temp_email_addresses", ["temp_email_address"], name: "index_temp_email_addresses_on_temp_email_address", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.string   "oauth_email"
    t.string   "preferred_email"
    t.string   "password_digest"
    t.datetime "oauth_expires_at"
    t.string   "phone_number"
    t.uuid     "password_reset_code"
    t.datetime "password_reset_code_expires_at"
    t.string   "image_path"
    t.boolean  "teacher"
    t.boolean  "parent"
    t.boolean  "community_member"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
