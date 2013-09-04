class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :options => 'default charset=utf8', :force => true do |t|
      t.column :body,         :text       # testo del commento
      t.column :user_id,      :integer    # utente che ha postato il commento
      t.column :author,       :string     # autore del commento (utente non registrato)
      t.column :email,        :string     # email dell'autore del commento (utente non registrato)
      t.column :created_on,   :datetime
      t.column :updated_on,   :datetime
      t.column :review_id,    :integer    # recensione commentata
      t.column :page_id,      :integer    # pagina commentata
      t.column :is_spam,      :integer    # 1 => il commento è spam
    end
    
    add_index :comments, :user_id
    add_index :comments, :review_id
    add_index :comments, :page_id
  end

  def self.down
    drop_table :comments
  end
end
