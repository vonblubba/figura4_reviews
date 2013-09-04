module AtechMedia
  module Backup
    CONFIG = YAML::load(ERB.new(IO.read("#{RAILS_ROOT}/config/backup.yml")).result).symbolize_keys[:backup]
    
    def self.now
        
      database_config = ActiveRecord::Base.configurations[RAILS_ENV]
      database_config = ActiveRecord::Base.configurations[database_config] unless database_config.class == Hash
      
      filename = CONFIG["file_prefix"] + Time.now.strftime("%Y.%m.%d_%k-%M-%S")
      file = [CONFIG["path"], filename].join("/")
      
      ## Dumping the SQL File
      command = "mysqldump -p#{database_config["password"]} -u #{database_config["username"]} #{database_config["database"]} >> #{file}.sql"
      system(command)
      
      if CONFIG["compress"]
        ## Compressing with tar.gz
        command = "cd #{CONFIG['path']}; tar czvf #{filename}.tar.gz #{filename}.sql >> /dev/null"
        system(command)
        ## Removing uncompressed sql file
        command = "rm #{file}.sql >> /dev/null"
        system(command)
      end
      
      result = File.exists?(file + ".tar.gz") && !File.exists?(file + ".sql") ? true : false
      
      DatabaseBackup.create(:file_name => filename + ".tar.gz", :path => CONFIG["path"], :file_size => File.size(file + ".tar.gz")) if result
      
      return result
    end

  end
end
