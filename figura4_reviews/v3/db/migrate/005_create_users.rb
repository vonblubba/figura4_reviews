class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :options => 'default charset=utf8', :force => true do |t|
      t.column :name,             :string     # username
      t.column :hashed_password,  :string     
      t.column :salt,             :string     
      t.column :email,            :string  
      t.column :homepage,         :string
      t.column :is_admin,         :integer
      t.column :is_editor,        :integer
    end
    
    add_index :users, :name
  end

  def self.down
    drop_table :users
  end
end
