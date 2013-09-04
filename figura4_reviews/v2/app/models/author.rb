class Author < ActiveRecord::Base
  has_many :reviews,        :dependent => :nullify
  has_one  :author_picture, :dependent => :destroy
  has_one  :external_link,  :dependent => :destroy     # link alla fonte della biografia
  validates_presence_of :first_name, :second_name, :message => "non può essere vuoto"
  validates_associated :author_picture, :message => "non valida"
  validates_associated :external_link, :message => "non valido"
  
  def full_name
    self.first_name + ' ' + self.second_name
  end
  
  protected
  
  def validate_on_create
    if Author.find_by_first_name_and_second_name(first_name, second_name)
      errors.add_to_base("autore già inserito")
    end
  end
end
