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

ActiveRecord::Schema.define(:version => 16) do

  create_table "authors", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.text     "bio"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "authors", ["second_name"], :name => "index_authors_on_second_name"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.string   "author"
    t.string   "email"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "review_id"
    t.integer  "page_id"
    t.integer  "is_spam"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"
  add_index "comments", ["review_id"], :name => "index_comments_on_review_id"
  add_index "comments", ["page_id"], :name => "index_comments_on_page_id"

  create_table "database_backups", :force => true do |t|
    t.string   "file_name"
    t.string   "path"
    t.integer  "file_size"
    t.datetime "created_at"
  end

  create_table "emails", :force => true do |t|
    t.string   "sender"
    t.string   "sender_address"
    t.text     "body"
    t.integer  "is_spam"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "emails", ["is_spam"], :name => "index_emails_on_is_spam"

  create_table "links", :force => true do |t|
    t.string  "title"
    t.text    "description"
    t.integer "review_id"
    t.integer "page_id"
    t.integer "author_id"
    t.integer "user_id"
    t.integer "comment_id"
    t.integer "no_follow"
    t.string  "type"
    t.integer "in_link_section"
    t.text    "link_url"
    t.string  "controller"
    t.string  "action"
    t.integer "lid"
  end

  add_index "links", ["page_id"], :name => "page_id"
  add_index "links", ["user_id"], :name => "user_id"
  add_index "links", ["review_id"], :name => "index_links_on_review_id"
  add_index "links", ["comment_id"], :name => "index_links_on_comment_id"
  add_index "links", ["author_id"], :name => "index_links_on_author_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "second_title"
    t.text     "html_body"
    t.text     "meta_description"
    t.string   "meta_keywords"
    t.integer  "user_id"
    t.integer  "published"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.text     "description"
  end

  add_index "pages", ["user_id"], :name => "index_pages_on_user_id"

  create_table "pictures", :force => true do |t|
    t.string  "name"
    t.string  "content_type"
    t.string  "type"
    t.binary  "data"
    t.integer "user_id"
    t.integer "review_id"
    t.integer "author_id"
    t.string  "comment"
    t.integer "video_review_id"
    t.integer "order"
    t.text    "comment_on_page"
    t.integer "page_id"
    t.integer "order_on_page"
  end

  add_index "pictures", ["user_id"], :name => "index_pictures_on_user_id"
  add_index "pictures", ["review_id"], :name => "index_pictures_on_review_id"
  add_index "pictures", ["author_id"], :name => "index_pictures_on_author_id"
  add_index "pictures", ["video_review_id"], :name => "index_pictures_on_video_review_id"
  add_index "pictures", ["page_id"], :name => "index_pictures_on_page_id"

  create_table "quotes", :force => true do |t|
    t.text    "italian_text"
    t.text    "original_text"
    t.string  "source"
    t.string  "author"
    t.integer "review_id"
    t.integer "random"
  end

  add_index "quotes", ["review_id"], :name => "index_quotes_on_review_id"
  add_index "quotes", ["random"], :name => "index_quotes_on_random"

  create_table "reviews", :force => true do |t|
    t.string   "italian_title"
    t.string   "italian_article"
    t.string   "italian_subtitle"
    t.string   "original_title"
    t.string   "original_article"
    t.string   "original_subtitle"
    t.integer  "pages"
    t.text     "plot"
    t.text     "review"
    t.string   "year"
    t.string   "editor"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "vote"
    t.string   "type"
    t.text     "final_words"
    t.integer  "language"
    t.integer  "author_id"
    t.integer  "published"
    t.integer  "user_id"
    t.text     "reason_to_read"
    t.text     "reason_to_avoid"
    t.text     "actors"
    t.string   "nation"
    t.string   "seasons"
  end

  add_index "reviews", ["author_id"], :name => "index_reviews_on_author_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"
  add_index "reviews", ["vote"], :name => "index_reviews_on_vote"
  add_index "reviews", ["created_on"], :name => "index_reviews_on_created_on"
  add_index "reviews", ["italian_title"], :name => "index_reviews_on_italian_title"
  add_index "reviews", ["original_title"], :name => "index_reviews_on_original_title"

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
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
    t.string "name"
    t.string "hashed_password"
    t.string "salt"
    t.string "email"
  end

  add_index "users", ["name"], :name => "index_users_on_name"

end
