class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails, :options => 'default charset=utf8', :force => true do |t|
      t.column :sender,             :string
      t.column :sender_address,     :string
      t.column :body,               :text
      t.column :is_spam,            :integer # 1 => � spam
      t.column :created_on,         :datetime   
      t.column :updated_on,         :datetime   
    end
    
    add_index :emails, :is_spam
  end

  def self.down
    drop_table :emails
  end
end
