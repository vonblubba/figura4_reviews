require 'fileutils'

backup_config = File.dirname(__FILE__) + '/../../../config/backup.yml'
FileUtils.cp File.dirname(__FILE__) + '/backup.yml.tpl', backup_config unless File.exist?(backup_config)