class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews, :options => 'default charset=utf8', :force => true do |t|
      # attributi comuni
      t.column :italian_title,      :string     # Titolo italiano (lasciare vuoto se inedito in italia)
      t.column :italian_article,    :string     # Eventuale articolo del titolo italiano
      t.column :italian_subtitle,   :string     # Eventuale sottotitolo italiano (oppure n° volume in una saga)
      t.column :original_title,     :string     # Titolo originale (*)
      t.column :original_article,   :string     # Eventuale articolo del titolo originale
      t.column :original_subtitle,  :string     # Eventuale sottotitolo originale (oppure n° volume in una saga)
      t.column :plot,               :text       # La trama in breve
      t.column :review,             :text       # La mia opinione (*)
      t.column :year,               :string     # Anno di prima pubblicazione in lingua originale
      t.column :created_on,         :datetime   # Data creazione recensione
      t.column :updated_on,         :datetime   # Data modifica recensione
      t.column :vote,               :integer    # Voto (1-10) (*)
      t.column :type,               :string     
      t.column :final_words,        :text       # In conclusione
      t.column :author_id,          :integer    # Autore/regista
      t.column :published,          :integer    # 0 => no, 1 => si
      t.column :user_id,            :integer    # Autore della recensione
      t.column :reason_to_read,     :text       # Ragioni per leggere/guardare
      t.column :reason_to_avoid,    :text       # Ragioni per evitare
      
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
    
    add_index :reviews, :author_id
    add_index :reviews, :user_id
    add_index :reviews, :vote
    add_index :reviews, :created_on
    add_index :reviews, :italian_title
    add_index :reviews, :original_title
  end

  def self.down
    drop_table :reviews
  end
end




#                                    --- books
#                                   |
#            ------ paper review ---|
#           |                       |
#           |                        --- comics
# review ---|
#           |                        --- film
#           |                       |
#            ------ video review ---|
#                                   |
#                                    --- tv series