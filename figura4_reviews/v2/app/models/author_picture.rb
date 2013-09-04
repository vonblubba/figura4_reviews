class AuthorPicture < Picture
  belongs_to :author
  
  def comment
    self.author.full_name
  end
end