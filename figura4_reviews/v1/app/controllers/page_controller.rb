class PageController < ApplicationController
  
  layout "review"
  
  def show
    begin
      @page_name = "pages"
      @page = Page.find(params[:id])
      @page_title = @page.title
    rescue
      logger.error("Attempt to access invalid page #{params[:id]}" )
      flash[:notice] = "Pagina non valida"
      redirect_to({:controller => "review", :action => "index"})
    end
  end
  
  def index
    @page_name = "pages"
    @all_pages = Page.find(:all, :conditions => "published = 1", :order => "title")
  end 
  
end
