class ExternalLink < Link
  belongs_to :user
  belongs_to :author
  belongs_to :comment
  validates_presence_of :link_url
  
  def before_save
    self.link_url = "http://#{self.link_url.gsub("http://", "")}" unless self.link_url.nil? or self.link_url.blank?
  end
end