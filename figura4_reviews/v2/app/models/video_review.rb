class VideoReview < Review
  has_many :screenshots, :dependent => :destroy
end