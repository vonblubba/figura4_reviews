class HomeController < ApplicationController
  layout "default"
  before_filter :set_section
  
  def set_section
    $section = "home"
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def index
    @recent_posts = Node.find(:all, :conditions => "published = 1", :limit => 10, :order => "created_on DESC")
    @recent_comments = Comment.find(:all, :limit => 5, :conditions => "is_spam = 0", :order => "created_on DESC")
    @meta_keywords = "recensioni, libri, film, serie tv, fumetti, fantascienza, fantasy"
    @meta_description = "Recensioni di libri, film, fumetti e serie tv, con un occhio di riguardo alla fantascienza ed al fantasy"
  end
end
