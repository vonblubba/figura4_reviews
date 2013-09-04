class AddSecondTitle < ActiveRecord::Migration
  def self.up
    add_column :reviews, :second_italian_title, :string
    add_column :reviews, :second_original_title, :string
  end

  def self.down
    remove_column :reviews, :second_italian_title
    remove_column :reviews, :second_original_title
  end
end
