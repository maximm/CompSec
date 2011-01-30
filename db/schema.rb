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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110130161740) do

  create_table "databases", :force => true do |t|
    t.string   "masters"
    t.boolean  "mastersI"
    t.integer  "age"
    t.boolean  "ageI"
    t.boolean  "sex"
    t.integer  "score"
    t.boolean  "scoreI"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filehandlers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "masters"
    t.integer  "age"
    t.boolean  "sex"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstNameStil1"
    t.string   "lastNameStil1"
    t.string   "firstNameStil2"
    t.string   "lastNamestil2"
    t.string   "stil1"
    t.string   "stil2"
  end

end
