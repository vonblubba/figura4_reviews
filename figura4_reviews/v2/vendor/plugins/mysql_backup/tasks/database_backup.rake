namespace :db do 
  task :backup => :environment do
    puts "Running MySQL Database Backup"
    AtechMedia::Backup.now
  end
end