class DatabaseBackup < ActiveRecord::Base
  validates_presence_of :file_name, :path, :file_size
  validates_numericality_of :file_size    
end