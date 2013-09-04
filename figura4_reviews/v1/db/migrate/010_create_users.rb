class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :options => 'default charset=utf8' do |t|
      t.column :name,             :string
      t.column :hashed_password,  :string
      t.column :salt,             :string
      t.column :email,            :string
      t.column :homepage,         :string
    end
  end

  def self.down
    drop_table :users
  end
end
