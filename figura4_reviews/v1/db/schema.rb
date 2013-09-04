# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 18) do

  create_table "authors", :force => true do |t|
    t.column "first_name",  :string
    t.column "second_name", :string
    t.column "bio",         :text
    t.column "picture",     :text
    t.column "created_on",  :datetime
    t.column "updated_on",  :datetime
  end

  create_table "comments", :force => true do |t|
    t.column "body",       :text
    t.column "author",     :string
    t.column "email",      :string
    t.column "homepage",   :string
    t.column "created_on", :datetime
    t.column "updated_on", :datetime
    t.column "review_id",  :integer
  end

  create_table "pages", :force => true do |t|
    t.column "title",            :string
    t.column "second_title",     :string
    t.column "html_body",        :text
    t.column "meta_description", :text
    t.column "meta_keywords",    :string
    t.column "user_id",          :integer
    t.column "published",        :integer
    t.column "created_on",       :datetime
    t.column "updated_on",       :datetime
    t.column "description",      :text
  end

  create_table "quotes", :force => true do |t|
    t.column "italian_text",  :text
    t.column "original_text", :text
    t.column "source",        :string
    t.column "author",        :string
    t.column "review_id",     :integer
    t.column "random",        :integer
  end

  create_table "reviews", :force => true do |t|
    t.column "italian_title",         :string
    t.column "italian_article",       :string
    t.column "original_title",        :string
    t.column "original_article",      :string
    t.column "pages",                 :integer
    t.column "plot",                  :text
    t.column "review",                :text
    t.column "year",                  :string
    t.column "editor",                :string
    t.column "created_on",            :datetime
    t.column "updated_on",            :datetime
    t.column "cover",                 :string
    t.column "vote",                  :integer
    t.column "media",                 :integer
    t.column "final_words",           :text
    t.column "language",              :integer
    t.column "author_id",             :integer
    t.column "published",             :integer
    t.column "user_id",               :integer
    t.column "reason_to_read",        :text
    t.column "reason_to_avoid",       :text
    t.column "actors",                :text
    t.column "second_italian_title",  :string
    t.column "second_original_title", :string
  end

  create_table "reviews_tags", :id => false, :force => true do |t|
    t.column "tag_id",    :integer
    t.column "review_id", :integer
  end

  create_table "screenshots", :force => true do |t|
    t.column "image",     :string
    t.column "text",      :string
    t.column "number",    :integer
    t.column "review_id", :integer
  end

  create_table "tags", :force => true do |t|
    t.column "name",        :string
    t.column "description", :text
  end

  create_table "users", :force => true do |t|
    t.column "name",            :string
    t.column "hashed_password", :string
    t.column "salt",            :string
    t.column "email",           :string
    t.column "homepage",        :string
  end

end