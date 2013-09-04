class Link < ActiveRecord::Base
  validates_presence_of :url,    :message => "non può essere vuoto"
  validates_presence_of :page_title,    :message => "non può essere vuoto"
  
  protected
  def before_save
    self.url = "http://#{self.url.gsub("http://", "")}"
  end
end
