class Node < ActiveRecord::Base
  has_many :quotes,   :dependent => :destroy
  has_many :comments, :dependent => :destroy, :conditions => 'is_spam = 0'
  belongs_to :user
  acts_as_taggable
  validates_presence_of :page_title, :published, :user_id
  validates_associated :quotes,   :message => "non valide"
  
  def to_param
    self.url
  end
end
