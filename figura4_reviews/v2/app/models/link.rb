class Link < ActiveRecord::Base
  belongs_to :review
  belongs_to :page
  validates_presence_of :title, :no_follow
  
  protected
end
