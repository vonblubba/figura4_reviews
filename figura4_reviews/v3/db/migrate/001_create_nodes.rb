class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes, :options => 'default charset=utf8', :force => true do |t|
      # attributi comuni
      t.column :page_title,         :string     # Titolo della pagina
      t.column :url,                :string     # URL della pagina
      t.column :meta_keywords,      :text       # Meta keywords
      t.column :meta_description,   :text       # Meta description    
      t.column :user_id,            :integer    # Autore della pagina
      t.column :published,          :integer    # 0 => no, 1 => si
      t.column :type,               :string    
      t.column :created_on,         :datetime   
      t.column :updated_on,         :datetime   
      
      # blog entry
      t.column :body,               :text       # Testo dell'entry
      
      # review
      t.column :italian_title,      :string     # Titolo italiano (lasciare vuoto se inedito in italia)
      t.column :italian_article,    :string     # Eventuale articolo del titolo italiano
      t.column :italian_subtitle,   :string     # Eventuale sottotitolo italiano (oppure n° volume in una saga)
      t.column :original_title,     :string     # Titolo originale (*)
      t.column :original_article,   :string     # Eventuale articolo del titolo originale
      t.column :original_subtitle,  :string     # Eventuale sottotitolo originale (oppure n° volume in una saga)
      t.column :plot,               :text       # La trama in breve
      t.column :review,             :text       # La mia opinione (*)
      t.column :year,               :string     # Anno di prima pubblicazione in lingua originale
      t.column :vote,               :integer    # Voto (1-10) (*)
      t.column :author_id,          :integer    # Autore/regista

      # video review (film + tv series)
      t.column :actors,             :text       # Attori
      t.column :nation,             :string     # Nazione
      
      # paper review (books + comics)
      t.column :pages,              :integer    # N° pagine
      t.column :editor,             :string     # Editore
      t.column :language,           :integer    # 0 => italiano, 1 => inglese

      # tv series
      t.column :seasons,            :string     # Stagioni
    end
    
    add_index :nodes, :author_id
    add_index :nodes, :user_id
    add_index :nodes, :vote
    add_index :nodes, :created_on
    add_index :nodes, :italian_title
    add_index :nodes, :original_title
  end

  def self.down
    drop_table :nodes
  end
end




#                                          --- books
#                                         |
#                  ------ paper review ---|
#                 |                       |
#                 |                        --- comics
#      -review ---|
#     |           |                        --- film
#     |           |                       |
#     |            ------ video review ---|
#     |                                   |
#     |                                    --- tv series
# node|
#     |
#     |
#     |
#      -blog_entry