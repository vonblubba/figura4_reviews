class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.column :page_title,         :string     # Titolo del sito
      t.column :description,        :text       # Descrizione
      t.column :url,                :string
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
