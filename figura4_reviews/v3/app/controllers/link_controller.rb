class LinkController < ApplicationController
  before_filter :set_section
  before_filter :authorize, :except => 'index'
  layout "default"
  
  def set_section
    $section = "links"
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def index
    @links = Link.find(:all, :order => 'created_at')
    @meta_keywords = "links, recensioni, libri, fumetti, serie tv, film"
    @meta_description = "Links a siti di interesse"
  end
  
  def new
    @link = Link.new
  end
  
  def edit
    @link = Link.find(params[:id])
  end
  
  def create
    @link = Link.new(params[:link])
    if @link.save
      flash[:notice] = 'Link aggiunto'
      redirect_back
    else
      render :action => 'new'
    end
  end
  
  def update
    if Link.update(params[:id], params[:link])
      flash[:notice] = 'Link modificato'
      redirect_back
    else
      render :action => 'edit', :id => @link
    end
  end
  
  def destroy
    Link.find(params[:id]).destroy
    flash[:notice] = 'Link eliminato'
    redirect_back
  end
end
