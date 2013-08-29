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

ActiveRecord::Schema.define(version: 20130828150737) do

  create_table "namespaces", force: true do |t|
    t.string   "name"
    t.string   "support"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "alias"
    t.string   "title"
    t.integer  "revision_id"
    t.integer  "namespace_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages_tags", force: true do |t|
    t.integer "page_id"
    t.integer "tag_id"
  end

  create_table "permissions", force: true do |t|
    t.string   "ldap_user"
    t.string   "model"
    t.integer  "fk"
    t.string   "ability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revisions", force: true do |t|
    t.string   "text"
    t.integer  "page_id"
    t.string   "ldap_editor"
    t.string   "changelog"
    t.integer  "parent_revision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true

end
