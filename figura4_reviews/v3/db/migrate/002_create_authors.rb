class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors, :options => 'default charset=utf8', :force => true do |t|
      t.column :first_name,          :string       # nome
      t.column :second_name,         :string       # cognome
      t.column :bio,                 :text         # biografia
      t.column :bio_source,          :string       # fonte biografia
      t.column :created_on,          :datetime
      t.column :updated_on,          :datetime
    end
    
    add_index :authors, :second_name
  end

  def self.down
    drop_table :authors
  end
end
