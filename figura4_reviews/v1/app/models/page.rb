class Page < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :title, :html_body, :meta_description, :meta_keywords
  validates_uniqueness_of :title
  
  @@images_path = "images/pages/"
  
  def to_param
    "#{id}-#{self.title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end  
  
end
