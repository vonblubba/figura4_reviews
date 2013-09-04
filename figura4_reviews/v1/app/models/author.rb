class Author < ActiveRecord::Base
  has_many :reviews
  
  validates_presence_of :first_name, :second_name, :message => "non può essere vuoto"

  @@picture_path = "images/authors/"
  @@noimage = "noimage.jpg"
  
  def validate
    unless picture.nil? or picture.blank?
      splitted = picture.split(".")
      format_ok = (splitted.last == "gif" or splitted.last == "jpg" or splitted.last == "jpeg" or splitted.last == "png") 
      errors.add(:picture, "Immagine non valida") unless format_ok 
    end
  end
  
  def Author.save_picture(picture)
    unless picture[:picture].nil? or picture[:picture].blank?
      file_name = Author.base_part_of(picture[:picture].original_filename)
      f = File.new(@@picture_path + file_name,'w')
      while !picture[:picture].eof
        f.write(picture[:picture].read(4096))
      end
      file_name
    else
      nil
    end
  end
  
  def picture_to_display
    if self.picture.nil? or self.picture.blank?
      @@noimage
    else
      self.picture
    end
  end
  
  def Author.base_part_of(file_name)
    name = File.basename(file_name)
    name.gsub(/[^\w._-]/, '' )
  end
  
  def Author.picture_path
    "/" + @@picture_path
  end
  
  def full_name
    self.first_name + ' ' + self.second_name
  end
  
  def Author.list_for_select
    authors_list = Author.find(:all, :order => "second_name") 
    formatted_authors_list = Array.new
    authors_list.each do |a|
      formatted_authors_list << { 'full_name' => a.second_name + ', ' + a.first_name,
                                  'id'        => a.id.to_s }
    end
    formatted_authors_list
  end
  
end
