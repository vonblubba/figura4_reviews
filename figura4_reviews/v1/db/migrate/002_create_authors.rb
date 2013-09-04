class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors, :options => 'default charset=utf8' do |t|
      t.column :first_name,   :string
      t.column :second_name,  :string
      t.column :bio,          :text
      t.column :picture,      :text
      t.column :created_on,   :datetime
      t.column :updated_on,   :datetime
    end
  end

  def self.down
    drop_table :authors
  end
end
