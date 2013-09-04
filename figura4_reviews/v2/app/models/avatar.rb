class Avatar < Picture
  belongs_to :user
  
  def comment
    self.user.name
  end
end