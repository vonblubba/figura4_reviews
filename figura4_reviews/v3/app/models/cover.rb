class Cover < Picture
  belongs_to :review
  
  def alt_tag
    if self.class == "BookReview" or self.class == "ComicReview"
      "copertina del #{self.review.media} '#{self.review.full_title}'"
    else
      "locandina del #{self.review.media} '#{self.review.full_title}'"
    end
  end
end
