class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags, :options => 'default charset=utf8' do |t|
       t.column  :name,           :string
       t.column  :description,    :text
    end
    
    create_table :reviews_tags, :id => false do |t|
       t.column  :tag_id,         :integer
       t.column  :review_id,       :integer
    end

  end

  def self.down
    drop_table :tags
    drop_table :reviews_tags
  end
end
