class InternalLink < Link
  validates_presence_of :controller, :action, :lid
end