class Author < ActiveRecord::Base
  has_many :reviews,        :dependent => :nullify
  has_one  :author_picture, :dependent => :destroy
  validates_presence_of :second_name,    :message => "non può essere vuoto"
  validates_associated  :author_picture, :message => "non valida"
  
  def full_name
    self.first_name + ' ' + self.second_name
  end
  
  protected
  def validate_on_create
    if Author.find_by_first_name_and_second_name(first_name, second_name)
      errors.add_to_base("autore già inserito")
    end
  end
  
  def before_save
    self.bio_source = "http://#{self.bio_source.gsub("http://", "")}" unless self.bio_source.blank?
  end
end
