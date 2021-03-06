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

ActiveRecord::Schema.define(:version => 20150211073401) do

  create_table "audios", :force => true do |t|
    t.integer  "medium_id"
    t.string   "title"
    t.string   "audio_url"
    t.text     "summary"
    t.string   "author"
    t.integer  "seconds"
    t.integer  "file_size"
    t.string   "url"
    t.string   "explicit"
    t.integer  "order"
    t.string   "closedcaptioned"
    t.string   "block"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "blogs", :force => true do |t|
    t.integer  "user_id"
    t.string   "title",                               :null => false
    t.string   "subtitle"
    t.string   "slug",                                :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "post_access", :default => "--- []\n"
    t.integer  "position",                            :null => false
  end

  create_table "books", :force => true do |t|
    t.integer  "no",          :null => false
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "edition_id"
  end

  create_table "cantos", :force => true do |t|
    t.integer  "no",          :null => false
    t.string   "title"
    t.string   "description"
    t.integer  "book_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "body",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "editions", :force => true do |t|
    t.string   "name"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "follows", :force => true do |t|
    t.integer  "followable_id",                      :null => false
    t.string   "followable_type",                    :null => false
    t.integer  "follower_id",                        :null => false
    t.string   "follower_type",                      :null => false
    t.boolean  "blocked",         :default => false, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "lines", :force => true do |t|
    t.integer  "no",         :null => false
    t.string   "line",       :null => false
    t.integer  "stanza_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "media", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "subtitle"
    t.text     "summary"
    t.string   "image_url"
    t.text     "category"
    t.string   "language"
    t.string   "explicit"
    t.string   "block"
    t.string   "complete"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notebooks", :force => true do |t|
    t.text     "line"
    t.text     "quote"
    t.text     "annotation"
    t.string   "start"
    t.integer  "startoffset"
    t.string   "end"
    t.integer  "endoffset"
    t.string   "externalurl"
    t.string   "uri"
    t.integer  "line_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.integer  "priority"
    t.string   "category"
    t.text     "content"
    t.text     "md_content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "parent"
    t.string   "url"
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"

  create_table "posts", :force => true do |t|
    t.integer  "blog_id"
    t.string   "title",                           :null => false
    t.text     "content"
    t.text     "md_content"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "excerpt"
    t.string   "url"
    t.datetime "published_at"
    t.boolean  "draft",        :default => true
    t.string   "series_title"
    t.string   "subtitle"
    t.string   "show_excerpt"
    t.integer  "author_id"
    t.boolean  "featured",     :default => false
    t.integer  "number"
    t.datetime "deleted_at"
  end

  add_index "posts", ["blog_id", "number"], :name => "index_posts_on_blog_id_and_number", :unique => true
  add_index "posts", ["deleted_at"], :name => "index_posts_on_deleted_at"

  create_table "rewrites", :force => true do |t|
    t.text     "source"
    t.text     "destination"
    t.integer  "code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sections", :force => true do |t|
    t.integer  "no",         :null => false
    t.string   "name"
    t.integer  "canto_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "runningno"
  end

  create_table "stanzas", :force => true do |t|
    t.integer  "no",                            :null => false
    t.integer  "runningno"
    t.integer  "section_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "featured",   :default => false, :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tasks", :force => true do |t|
    t.string   "task"
    t.string   "proposedby"
    t.text     "desc"
    t.date     "sdate"
    t.date     "edate"
    t.date     "pdate"
    t.string   "person"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "uploads", :force => true do |t|
    t.integer  "post_id"
    t.string   "photo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "music"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "username",                                             :null => false
    t.string   "email",                                                :null => false
    t.string   "photo"
    t.integer  "role_id"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
