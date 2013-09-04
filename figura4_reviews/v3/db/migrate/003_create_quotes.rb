class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes, :options => 'default charset=utf8', :force => true do |t|
      t.column :body,              :text     # testo della quote
      t.column :source,            :string   # fonte della quote (nel contesto del libro/film)
      t.column :node_id,           :integer
      t.column :random,            :integer  # 1 => inclusa nelle random quotes
    end
    
    add_index :quotes, :node_id
    add_index :quotes, :random
  end

  def self.down
    drop_table :quotes
  end
end
