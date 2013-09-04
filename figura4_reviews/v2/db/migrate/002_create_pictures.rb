class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures , :options => 'default charset=utf8', :force => true do |t|
      # attributi comuni   
      t.column :name,             :string       # nome file senza estensione
      t.column :content_type,     :string       # estensione
      t.column :type,             :string       
      t.column :data,             :blob         # dati immagine
      
      # avatar
      t.column :user_id,          :integer
      
      # cover
      t.column :review_id,        :integer
      
      # author picture
      t.column :author_id,        :integer
      
      # screenshot
      t.column :comment,          :string       # didscalia
      t.column :video_review_id,  :integer
      t.column :order,            :integer      # colonna per ordinamento screenshots
      
      # page_picture
      t.column :comment_on_page,  :text
      t.column :page_id,          :integer
      t.column :order_on_page,    :integer
    end
    
    add_index :pictures, :user_id
    add_index :pictures, :review_id
    add_index :pictures, :author_id
    add_index :pictures, :video_review_id
    add_index :pictures, :page_id
  end

  def self.down
    drop_table :pictures
  end
end
