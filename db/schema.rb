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

ActiveRecord::Schema.define(version: 2018_09_04_054544) do

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "vorname"
    t.string "mail"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "presentations", force: :cascade do |t|
    t.string "Name"
    t.string "Klasse"
    t.string "Titel"
    t.string "Fach"
    t.string "Betreuer"
    t.string "Zimmer"
    t.string "Von"
    t.string "Bis"
    t.string "Datum"
    t.integer "Frei"
    t.integer "Besetzt"
    t.string "Besucher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schuelers", force: :cascade do |t|
    t.string "Vorname"
    t.string "Name"
    t.string "Klasse"
    t.string "Mail"
    t.string "Number"
    t.string "Code"
    t.boolean "Registered"
    t.string "Selected"
    t.string "Selected1"
    t.string "Selected2"
    t.boolean "Received"
    t.boolean "loginpermit"
    t.integer "req"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "Vorname"
    t.string "Name"
    t.string "Number"
    t.string "Mail"
    t.boolean "Received"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
