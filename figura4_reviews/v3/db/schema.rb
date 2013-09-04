# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 12) do

  create_table "authors", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.text     "bio"
    t.string   "bio_source"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "authors", ["second_name"], :name => "index_authors_on_second_name"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.string   "author"
    t.string   "email"
    t.string   "homepage"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "node_id"
    t.integer  "is_spam"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"
  add_index "comments", ["node_id"], :name => "index_comments_on_node_id"

  create_table "links", :force => true do |t|
    t.string   "page_title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", :force => true do |t|
    t.string   "page_title"
    t.string   "url"
    t.text     "meta_keywords"
    t.text     "meta_description"
    t.integer  "user_id"
    t.integer  "published"
    t.string   "type"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.text     "body"
    t.string   "italian_title"
    t.string   "italian_article"
    t.string   "italian_subtitle"
    t.string   "original_title"
    t.string   "original_article"
    t.string   "original_subtitle"
    t.text     "plot"
    t.text     "review"
    t.string   "year"
    t.integer  "vote"
    t.integer  "author_id"
    t.text     "actors"
    t.string   "nation"
    t.integer  "pages"
    t.string   "editor"
    t.integer  "language"
    t.string   "seasons"
  end

  add_index "nodes", ["author_id"], :name => "index_nodes_on_author_id"
  add_index "nodes", ["user_id"], :name => "index_nodes_on_user_id"
  add_index "nodes", ["vote"], :name => "index_nodes_on_vote"
  add_index "nodes", ["created_on"], :name => "index_nodes_on_created_on"
  add_index "nodes", ["italian_title"], :name => "index_nodes_on_italian_title"
  add_index "nodes", ["original_title"], :name => "index_nodes_on_original_title"

  create_table "pictures", :force => true do |t|
    t.string  "name"
    t.string  "content_type"
    t.string  "type"
    t.binary  "data"
    t.integer "user_id"
    t.integer "review_id"
    t.integer "author_id"
  end

  add_index "pictures", ["user_id"], :name => "index_pictures_on_user_id"
  add_index "pictures", ["review_id"], :name => "index_pictures_on_review_id"
  add_index "pictures", ["author_id"], :name => "index_pictures_on_author_id"

  create_table "quotes", :force => true do |t|
    t.text    "body"
    t.string  "source"
    t.integer "node_id"
    t.integer "random"
  end

  add_index "quotes", ["node_id"], :name => "index_quotes_on_node_id"
  add_index "quotes", ["random"], :name => "index_quotes_on_random"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string  "name"
    t.string  "hashed_password"
    t.string  "salt"
    t.string  "email"
    t.string  "homepage"
    t.integer "is_admin"
    t.integer "is_editor"
  end

  add_index "users", ["name"], :name => "index_users_on_name"

end
