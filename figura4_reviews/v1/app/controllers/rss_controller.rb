class RssController < ApplicationController
  
  def index
    redirect_to(:action => 'feed')
  end
  
  def feed
    @reviews = Review.find(:all, :limit => 10, :order => "created_on DESC")
    render_without_layout
  end
  
end
