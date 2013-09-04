class SitemapController < ApplicationController
  def index
    redirect_to(:action => 'sitemap')
  end
  
  def sitemap
    # implementation of Google's SiteMaps protocol
    # Set the headers to reflect the type of content we're sending.
    headers['Content-Type'] = 'text/xml; charset=utf-8'
    # List the objects.
    @nodes = Node.find(:all, :conditions => "published = 1", :order => "created_on")
    # This line is not really necessary, but it makes 100% sure Rails doesn't apply a layout to the .rxml template.
    render :layout => false
  end
end
