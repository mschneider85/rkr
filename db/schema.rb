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

ActiveRecord::Schema.define(version: 20160928165749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "identities", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id",         null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
    t.datetime "last_sign_in_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "snippets", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "author_id"
    t.string   "title"
    t.text     "body"
    t.integer  "language",   default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["author_id"], name: "index_snippets_on_author_id", using: :btree
  end

  create_table "temp_associations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "temp_associatable_type"
    t.uuid     "temp_associatable_id"
    t.uuid     "uuid"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["temp_associatable_type", "temp_associatable_id"], name: "index_polymorphic_temp_associations", unique: true, using: :btree
    t.index ["uuid"], name: "index_temp_associations_on_uuid", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "votable_type"
    t.uuid     "votable_id"
    t.uuid     "voter_id"
    t.integer  "value",        default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", unique: true, using: :btree
    t.index ["voter_id"], name: "index_votes_on_voter_id", using: :btree
  end

end
