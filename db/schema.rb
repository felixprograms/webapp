# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_03_011936) do

  create_table "exchanges", force: :cascade do |t|
    t.text "description"
    t.float "amount"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "exchange_id"
    t.string "ticker"
    t.float "stocks"
    t.index ["exchange_id"], name: "index_stocks_on_exchange_id"
  end

  create_table "tamagotchis", force: :cascade do |t|
    t.string "name"
    t.integer "health"
    t.integer "fun"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "session_hash"
    t.string "email"
    t.string "reset_token"
  end

  create_table "zombies", force: :cascade do |t|
    t.string "name"
    t.integer "healthpoints"
  end

end
