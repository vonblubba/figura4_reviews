class AuthorController < ApplicationController
  layout "admin"
  
  before_filter :authorize
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def list
    @author_pages, @authors = paginate :authors, :order => 'second_name', :per_page => 20
  end
  
  def new
    @author = Author.new
  end

  def create
    @author = Author.new(params[:author])
    @author.external_link = ExternalLink.new(:title     => 'fonte della biografia',
                                             :link_url  => params[:link][:link_url],
                                             :no_follow => 1) unless params[:link][:link_url].blank?
    @author.author_picture = AuthorPicture.new(params[:picture]) unless params[:picture][:picture].blank?                                       
    if @author.save
      flash[:notice] = 'Autore creato.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @author = Author.find(params[:id])
    @link = @author.external_link
  end
  
  def update
    Author.update(params[:id], params[:author])
    @author = Author.find(params[:id])
    if params[:link][:link_url].blank?
      @author.external_link.destroy if not @author.external_link.nil?
    else
      if @author.external_link.nil?
        @author.external_link = ExternalLink.new(:title     => 'fonte della biografia',
                                                 :link_url  => params[:link][:link_url],
                                                 :no_follow => 1)
      else
        @author.external_link.link_url = params[:link][:link_url]
        @author.external_link.save
      end
    end
    if params[:delete_author_picture] == "1" and not params[:delete_author_picture].nil? 
      unless @author.author_picture.nil?
        @author.author_picture.destroy
      end
    else
      unless params[:picture][:picture].blank?
        unless @author.author_picture.nil?
          @author.author_picture.destroy 
        end
        @author.author_picture = AuthorPicture.new(params[:picture])                                       
      end
    end  
    if @author.save
      flash[:notice] = 'Autore modificato.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
