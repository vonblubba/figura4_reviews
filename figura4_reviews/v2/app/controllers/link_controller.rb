class LinkController < ApplicationController
  layout "admin"
  before_filter :set_section
  before_filter :authorize, :except => 'index'
  
  def set_section
    $section = "links"
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :destroy_internal_link, :destroy_external_link, 
                                      :create, :create_internal_link, :create_external_link, 
                                      :update, :update_internal_link, :update_external_link ],
         :redirect_to => { :action => :list }
  
  def index
    @links = Link.find(:all, :conditions => "in_link_section = 1")
    @meta_keywords = "links"
    @meta_description = "Links sul tema"
    render :layout => 'review'
  end

  def list
    @links = Link.find(:all, :conditions => "in_link_section = 1")
  end
  
  def new_internal_link
    @internal_link = InternalLink.new
    @review = Review.find(params[:id])
  end
  
  def new_external_link
    @external_link = InternalLink.new
    @review = Review.find(params[:id])
  end
  
  def new
    @external_link = ExternalLink.new  
  end

  def create
    @external_link = ExternalLink.new(params[:external_link])
    @external_link.in_link_section = 1
    if @external_link.save
      flash[:notice] = 'Link creato.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  
  def create_internal_link
    @internal_link = InternalLink.new(params[:internal_link])
    @internal_link.review = Review.find(params[:id])
    @internal_link.no_follow = 1
    if @internal_link.save
      flash[:notice] = 'Link creato.'
      redirect_to({ :controller => 'review', :action => 'edit_links', :id => params[:id] })
    else
      @review = @internal_link.review
      render :action => 'new_internal_link'
    end
  end
  
  def create_external_link
    @external_link = ExternalLink.new(params[:external_link])
    @external_link.review = Review.find(params[:id])
    if @external_link.save
      flash[:notice] = 'Link creato.'
      redirect_to({ :controller => 'review', :action => 'edit_links', :id => params[:id] })
    else
      @review = @external_link.review
      render :action => 'new_external_link'
    end
  end

  def edit_internal_link
    @internal_link = InternalLink.find(params[:id])
  end
  
  def edit_external_link
    @external_link = ExternalLink.find(params[:id])
  end
  
  def edit
    @external_link = ExternalLink.find(params[:id])
  end

  def update_internal_link
    if InternalLink.update(params[:id], params[:internal_link])
      flash[:notice] = 'Link modificato.'
      redirect_to :action => 'list_related_links', :id => InternalLink.find(params[:id]).review.id
    else
      @internal_link = InternalLink.find(params[:id])
      @review = @internal_link.review
      render :action => 'edit_internal_link'
    end
  end
  
  def update_external_link
    if ExternalLink.update(params[:id], params[:external_link])
      flash[:notice] = 'Link modificato.'
      redirect_to :action => 'list_related_links', :id => ExternalLink.find(params[:id]).review.id
    else
      @external_link = ExternalLink.find(params[:id])
      @review = @external_link.review
      render :action => 'edit_external_link'
    end
  end
  
  def update
    if ExternalLink.update(params[:id], params[:external_link])
      flash[:notice] = 'Link modificato.'
      redirect_to :action => 'list_links'
    else
      @external_link = ExternalLink.find(params[:id])
      render :action => 'edit_link'
    end
  end

  def destroy_internal_link
    @internal_link = InternalLink.find(params[:id])
    id = @internal_link.review.id
    @internal_link.destroy
    redirect_to :action => 'list_related_links', :id => id
  end
  
  def destroy_external_link
    @external_link = ExternalLink.find(params[:id])
    id = @external_link.review.id
    @external_link.destroy
    redirect_to :action => 'list_related_links', :id => id
  end
  
  def destroy
    ExternalLink.find(params[:id]).destroy
    redirect_to :action => 'list_links'
  end
end
