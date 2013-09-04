class SitemapController < ApplicationController
  def index
    redirect_to(:action => 'sitemap')
  end
  def sitemap
    # implementation of Google's SiteMaps protocol
    # Set the headers to reflect the type of content we're sending.
    @headers['Content-Type'] = 'text/xml; charset=utf-8'
    # List the objects.
    @reviews = Review.find(:all, :conditions => "published = 1")
    @pages = Page.find(:all, :conditions => "published = 1")
    # This line is not really necessary, but it makes 100% sure Rails doesn't apply a layout to the .rxml template.
    render_without_layout
  end
end
