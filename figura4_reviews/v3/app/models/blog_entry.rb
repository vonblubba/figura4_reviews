class BlogEntry < Node
  validates_presence_of :page_title, :body
  after_create :generate_page_url
  
  def generate_page_url
    self.url = "#{self.id}-#{self.page_title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-') 
    self.save
  end
end
