class PageController < ApplicationController
  layout "admin"
  before_filter :set_section
  before_filter :authorize, :except => [ 'index', 'show' ]
  
  def set_section
    $section = "pages"
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def index
    @pages = Page.find(:all, :conditions => "published = 1", :order => "created_on")
    @meta_keywords = "approfondimenti"
    @meta_description = "Pagine di approfondimento di carattere generale"
    render :layout => 'review'
  end
  
  def show
    begin
      @page = Page.find(params[:id])
      @page_title = @page.title
      @meta_keywords = "approfondimenti"
      @meta_description = "#{@page.title} - #{@page.second_title}"
      render :layout => 'review'
    rescue
      logger.error("Attempt to access invalid page #{params[:id]}" )
      flash[:notice] = "Pagina non valida"
      redirect_to({:controller => "review", :action => "index"})
    end
  end
  
  def list
    @page_pages, @pages = paginate :pages, :order => 'title', :per_page => 20
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    @page.user = User.find(session[:user_id])
    if @page.save
      flash[:notice] = 'Pagina creata.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    if Page.update(params[:id], params[:page])
      flash[:notice] = 'Pagina modificata.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Page.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
