class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes, :options => 'default charset=utf8' do |t|
      t.column :italian_text,      :text
      t.column :original_text,     :text
      t.column :source,            :string
      t.column :author,            :string
      t.column :review_id,         :integer
      t.column :random,            :integer
    end
  end

  def self.down
    drop_table :quotes
  end
end
