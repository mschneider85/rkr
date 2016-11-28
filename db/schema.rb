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

ActiveRecord::Schema.define(version: 20161124212802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "ar_internal_metadata", primary_key: "key", id: :string, force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "links", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "author_id"
    t.string   "title"
    t.string   "url"
    t.integer  "votes_count", default: 0, null: false
    t.integer  "votes_sum",   default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.json     "preview"
    t.index ["author_id"], name: "index_links_on_author_id", using: :btree
    t.index ["votes_count"], name: "index_links_on_votes_count", using: :btree
    t.index ["votes_sum"], name: "index_links_on_votes_sum", using: :btree
  end

  create_table "snippets", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "author_id"
    t.string   "title"
    t.text     "body"
    t.integer  "language",    default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "votes_sum",   default: 0, null: false
    t.integer  "votes_count", default: 0, null: false
    t.index ["author_id"], name: "index_snippets_on_author_id", using: :btree
    t.index ["votes_count"], name: "index_snippets_on_votes_count", using: :btree
    t.index ["votes_sum"], name: "index_snippets_on_votes_sum", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
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
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", using: :btree
    t.index ["voter_id"], name: "index_votes_on_voter_id", using: :btree
  end


  create_view :posts, materialized: true,  sql_definition: <<-SQL
      SELECT links.id AS searchable_id,
      'Link'::text AS searchable_type,
      links.title,
      links.url AS body,
      links.votes_count,
      links.votes_sum,
      round((((log((GREATEST(abs(links.votes_sum), 1))::double precision) * sign((links.votes_sum)::double precision)) + ((date_part('epoch'::text, links.created_at) - (1134028003)::double precision) / (45000.0)::double precision)))::numeric, 7) AS hotness,
      links.created_at,
      links.author_id
     FROM links
  UNION
   SELECT snippets.id AS searchable_id,
      'Snippet'::text AS searchable_type,
      snippets.title,
      snippets.body,
      snippets.votes_count,
      snippets.votes_sum,
      round((((log((GREATEST(abs(snippets.votes_sum), 1))::double precision) * sign((snippets.votes_sum)::double precision)) + ((date_part('epoch'::text, snippets.created_at) - (1134028003)::double precision) / (45000.0)::double precision)))::numeric, 7) AS hotness,
      snippets.created_at,
      snippets.author_id
     FROM snippets;
  SQL

  add_index "posts", "date_trunc('week'::text, created_at)", name: "posts_creation_week_index", using: :btree
  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["created_at"], name: "index_posts_on_created_at", using: :btree
  add_index "posts", ["hotness"], name: "index_posts_on_hotness", using: :btree
  add_index "posts", ["votes_count"], name: "index_posts_on_votes_count", using: :btree
  add_index "posts", ["votes_sum"], name: "index_posts_on_votes_sum", using: :btree

end
