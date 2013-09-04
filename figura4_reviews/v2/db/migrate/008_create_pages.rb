class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages, :options => 'default charset=utf8', :force => true do |t|
      t.column :title,            :string     # titolo della pagina
      t.column :second_title,     :string     # eventuale sottotitolo
      t.column :description,      :text       # breve descrizione della pagina
      t.column :html_body,        :text       # contenuto html della pagina
      t.column :meta_description, :text       # meta-tag description
      t.column :meta_keywords,    :string     # meta-tag keywords
      t.column :user_id,          :integer    # autore
      t.column :published,        :integer    # stato di pubblicazione 0 => no, 1 => si
      t.column :created_on,       :datetime
      t.column :updated_on,       :datetime
    end
    
    add_index :pages, :user_id
  end

  def self.down
    drop_table :pages
  end
end