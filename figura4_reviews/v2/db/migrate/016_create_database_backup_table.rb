class CreateDatabaseBackupTable < ActiveRecord::Migration
  def self.up
    create_table :database_backups do |t|
      t.column :file_name, :string
      t.column :path, :string
      t.column :file_size, :integer
      t.column :created_at, :datetime
      
    end
  end

  def self.down
    drop_table :database_backups
  end
end