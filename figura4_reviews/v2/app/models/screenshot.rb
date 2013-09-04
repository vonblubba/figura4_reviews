class Screenshot < Picture
  belongs_to :video_review
  validates_presence_of :order
  validates_presence_of :comment
  validates_presence_of :data
end