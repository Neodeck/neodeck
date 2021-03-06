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

ActiveRecord::Schema.define(version: 20160613040941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deck_orders", force: :cascade do |t|
    t.string   "shipping_line_1"
    t.string   "shipping_line_2"
    t.string   "shipping_country"
    t.string   "shipping_city"
    t.string   "shipping_zip"
    t.boolean  "shipped"
    t.string   "tracking_number"
    t.float    "base_price"
    t.float    "shipping_price"
    t.integer  "user_id"
    t.integer  "deck_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "stripe_charge_id"
    t.string   "shipping_name"
    t.string   "shipping_state"
    t.boolean  "cancelled"
  end

  create_table "decks", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.text     "white_cards"
    t.text     "black_cards"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "watermark"
  end

  create_table "socket_api_applications", force: :cascade do |t|
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "two_factor_methods", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "verified"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.boolean  "admin"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest"
    t.string   "socket_auth_token"
    t.string   "name"
    t.boolean  "premium"
    t.string   "stripe_charge_id"
    t.integer  "premium_discount_percentage"
    t.integer  "premium_override_price"
    t.text     "custom_badges"
    t.text     "custom_script"
    t.string   "stripe_customer_id"
  end

end
