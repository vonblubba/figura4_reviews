class Page < ActiveRecord::Base
  belongs_to :user
  has_many   :comments,      :dependent => :destroy, :conditions => 'is_spam = 0'
  has_many   :links,         :dependent => :destroy
  has_many   :page_pictures, :dependent => :destroy
  #acts_as_taggable
  validates_presence_of   :title, :html_body, :meta_description, :meta_keywords, :published, :user_id, :description
  validates_uniqueness_of :title
  validates_associated :comments, :message => "non validi"
  validates_associated :links, :message => "non validi"
  validates_associated :page_pictures, :message => "non valide"
  
  def to_param
    "#{id}-#{self.title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')   # 2do: sostituire le accentate
  end
end
