class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :options => 'default charset=utf8', :force => true do |t|
      t.column :body,         :text       # testo del commento
      t.column :user_id,      :integer    # utente che ha postato il commento
      t.column :author,       :string     # autore del commento (utente non registrato)
      t.column :email,        :string     # email dell'autore del commento (utente non registrato)
      t.column :homepage,     :string     # homepage dell'autore del commento (utente non registrato)
      t.column :created_on,   :datetime
      t.column :updated_on,   :datetime
      t.column :node_id,      :integer    # nodo commentato
      t.column :is_spam,      :integer    # 1 => il commento è spam
      t.column :user_ip,      :string     # /
      t.column :user_agent,   :string     # | campi per akismet
      t.column :referrer,     :string     # \
    end
    
    add_index :comments, :user_id
    add_index :comments, :node_id
  end

  def self.down
    drop_table :comments
  end
end
