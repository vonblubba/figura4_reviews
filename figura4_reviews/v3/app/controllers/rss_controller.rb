class RssController < ApplicationController
  def index
    redirect_to(:action => 'feed')
  end
  
  def feed
    @nodes = Node.find(:all, :limit => 10, :conditions => "published = 1", :order => "created_on DESC")
    render :layout => false
  end
end
