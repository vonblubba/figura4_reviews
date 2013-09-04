class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links, :options => 'default charset=utf8', :force => true do |t|
      t.column :title,            :string     # titolo del link
      t.column :description,      :text       # descrizione del link
      t.column :review_id,        :integer
      t.column :page_id,          :integer
      t.column :author_id,        :integer
      t.column :user_id,          :integer
      t.column :comment_id,       :integer
      t.column :no_follow,        :integer    # rel="nofollow"  1 => nofollow
      t.column :type,             :string
      t.column :in_link_section,  :integer    # 1 => inserito nella pagina links
      
      # link esterni
      t.column :link_url,         :text       # url del link
      
      # link interni
      t.column :controller,       :string     # \
      t.column :action,           :string     #  |-->  identificazione link interno
      t.column :lid,              :integer    # /
    end
    
    add_index :links, :review_id
    add_index :links, :comment_id
    add_index :links, :author_id
  end

  def self.down
    drop_table :links
  end
end


#            ------ link esterno
#           |                       
#           |                       
# link   ---|
#           |                      
#           |                       
#            ------ link interno
