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

ActiveRecord::Schema.define(version: 20150602134413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "audios", force: :cascade do |t|
    t.integer  "medium_id"
    t.string   "title",           limit: 255
    t.string   "audio_url",       limit: 255
    t.text     "summary"
    t.string   "author",          limit: 255
    t.integer  "seconds"
    t.integer  "file_size"
    t.string   "url",             limit: 255
    t.string   "explicit",        limit: 255
    t.integer  "order"
    t.string   "closedcaptioned", limit: 255
    t.string   "block",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",     limit: 255
    t.string   "uid",          limit: 255
    t.string   "name",         limit: 255
    t.string   "oauth_token",  limit: 255
    t.string   "oauth_secret", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",       limit: 255,                                                     null: false
    t.string   "subtitle",    limit: 255
    t.string   "slug",        limit: 255,                                                     null: false
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
    t.string   "post_access", limit: 255, default: "--- []\n"
    t.integer  "position",                default: "nextval('blogs_position_seq'::regclass)", null: false
  end

  create_table "books", force: :cascade do |t|
    t.integer  "no",                      null: false
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "edition_id"
  end

  create_table "cantos", force: :cascade do |t|
    t.integer  "no",                      null: false
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.integer  "book_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "commentaries", force: :cascade do |t|
    t.integer  "section_id"
    t.hstore   "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "commentaries", ["data"], name: "commentaries_data", using: :gin

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "editions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "year"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                               null: false
    t.string   "followable_type", limit: 255,                 null: false
    t.integer  "follower_id",                                 null: false
    t.string   "follower_type",   limit: 255,                 null: false
    t.boolean  "blocked",                     default: false, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "lines", force: :cascade do |t|
    t.integer  "no",                     null: false
    t.string   "line",       limit: 255, null: false
    t.integer  "stanza_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "media", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",      limit: 255
    t.string   "subtitle",   limit: 255
    t.text     "summary"
    t.string   "image_url",  limit: 255
    t.text     "category"
    t.string   "language",   limit: 255
    t.string   "explicit",   limit: 255
    t.string   "block",      limit: 255
    t.string   "complete",   limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "notebooks", force: :cascade do |t|
    t.text     "line"
    t.text     "quote"
    t.text     "annotation"
    t.string   "start",       limit: 255
    t.integer  "startoffset"
    t.string   "end",         limit: 255
    t.integer  "endoffset"
    t.string   "externalurl", limit: 255
    t.string   "uri",         limit: 255
    t.integer  "line_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "permalink",  limit: 255
    t.integer  "priority"
    t.string   "category",   limit: 255
    t.text     "content"
    t.text     "md_content"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "parent"
    t.string   "url",        limit: 255
  end

  add_index "pages", ["permalink"], name: "index_pages_on_permalink", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "blog_id"
    t.string   "title",        limit: 255,                 null: false
    t.text     "content"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "md_content"
    t.text     "excerpt"
    t.string   "url",          limit: 255
    t.datetime "published_at"
    t.boolean  "draft",                    default: true
    t.string   "series_title", limit: 255
    t.string   "subtitle",     limit: 255
    t.string   "show_excerpt", limit: 255
    t.integer  "author_id"
    t.boolean  "featured",                 default: false
    t.datetime "deleted_at"
    t.integer  "number"
  end

  add_index "posts", ["blog_id", "number"], name: "index_posts_on_blog_id_and_number", unique: true, using: :btree
  add_index "posts", ["deleted_at"], name: "index_posts_on_deleted_at", using: :btree

  create_table "rewrites", force: :cascade do |t|
    t.text     "source"
    t.text     "destination"
    t.integer  "code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "no",                     null: false
    t.string   "name",       limit: 255
    t.integer  "canto_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "runningno"
  end

  create_table "stanzas", force: :cascade do |t|
    t.integer  "no",                         null: false
    t.integer  "runningno"
    t.integer  "section_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "featured",   default: false, null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "task",       limit: 255
    t.string   "proposedby", limit: 255
    t.text     "desc"
    t.date     "sdate"
    t.date     "edate"
    t.date     "pdate"
    t.string   "person",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "photo",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "music",      limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "username",               limit: 255,              null: false
    t.string   "email",                  limit: 255,              null: false
    t.string   "photo",                  limit: 255
    t.integer  "role_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "invitation_token",       limit: 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",        limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
