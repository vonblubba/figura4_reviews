class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages, :options => 'default charset=utf8' do |t|
      t.column :title,            :string
      t.column :second_title,     :string
      t.column :html_body,        :text
      t.column :meta_description, :text
      t.column :meta_keywords,    :string
      t.column :user_id,          :integer
      t.column :published,        :integer # 0 => no, 1 => si
      t.column :created_on,       :datetime
      t.column :updated_on,       :datetime
    end
  end

  def self.down
    drop_table :pages
  end
end
