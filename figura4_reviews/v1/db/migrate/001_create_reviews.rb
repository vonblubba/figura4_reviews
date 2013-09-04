class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews, :options => 'default charset=utf8' do |t|
      t.column :italian_title,      :string
      t.column :italian_article,    :string
      t.column :original_title,     :string
      t.column :original_article,   :string
      t.column :pages,              :integer
      t.column :plot,               :text
      t.column :review,             :text
      t.column :year,               :string
      t.column :editor,             :string
      t.column :created_on,         :datetime
      t.column :updated_on,         :datetime
      t.column :cover,              :string
      t.column :vote,               :integer
      t.column :media,              :integer # 0 => tv, 1 => libro, 2 => film, 3 => fumetto
      t.column :final_words,        :text
      t.column :language,           :integer # 0 => italiano, 1 => inglese
      t.column :author_id,          :integer
      t.column :published,          :integer # 0 => no, 1 => si
      t.column :user_id,            :integer
      t.column :reason_to_read,     :text
      t.column :reason_to_avoid,    :text
      t.column :actors,             :text
    end
  end

  def self.down
    drop_table :reviews
  end
end
