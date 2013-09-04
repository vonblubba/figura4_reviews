class AuthorPicture < Picture
  belongs_to :author
  
  def alt_tag
    self.author.full_name
  end
end
