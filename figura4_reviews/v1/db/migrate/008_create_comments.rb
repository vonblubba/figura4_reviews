class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :options => 'default charset=utf8' do |t|
      t.column :body,         :text
      t.column :author,       :string
      t.column :email,        :string
      t.column :homepage,     :string
      t.column :created_on,   :datetime
      t.column :updated_on,   :datetime
      t.column :review_id,    :integer
    end
  end

  def self.down
    drop_table :comments
  end
end
