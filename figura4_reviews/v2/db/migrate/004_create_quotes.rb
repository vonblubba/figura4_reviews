class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes, :options => 'default charset=utf8', :force => true do |t|
      t.column :italian_text,      :text     # testo tradotto in italiano della quote
      t.column :original_text,     :text     # testo originale della quote
      t.column :source,            :string   # fonte della quote (nel contesto del libro/film)
      t.column :author,            :string   # autore della quote (nel contesto del libro/film)
      t.column :review_id,         :integer
      t.column :random,            :integer  # 1 => inclusa nelle random quotes
    end
    
    add_index :quotes, :review_id
    add_index :quotes, :random
  end

  def self.down
    drop_table :quotes
  end
end