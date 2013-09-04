class Avatar < Picture
  belongs_to :user
  
  def alt_tag
    self.user.name
  end
end
