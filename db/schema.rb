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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110513093535) do

  create_table "filehandlers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "linuxtries", :force => true do |t|
    t.string   "username"
    t.integer  "trynbr"
    t.integer  "seed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studentusers", :force => true do |t|
    t.string   "stil"
    t.boolean  "project0"
    t.boolean  "project1"
    t.boolean  "project2"
    t.boolean  "project3"
    t.boolean  "project4"
    t.boolean  "project5"
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
