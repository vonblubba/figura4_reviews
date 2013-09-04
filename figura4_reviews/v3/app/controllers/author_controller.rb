class AuthorController < ApplicationController
  layout "default"
  before_filter :authorize
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def index
    redirect_to(:controller => "author" , :action => "list")
  end
  
  def list
    @authors = Author.paginate :page => params[:page], :order => 'second_name'
  end
  
  def new
    @author = Author.new
  end

  def create
    @author = Author.new(params[:author])
    @author.author_picture = AuthorPicture.new(params[:picture]) unless params[:picture][:picture].blank?                                       
    if @author.save
      flash[:notice] = 'Autore creato.'
      redirect_back
    else
      render :action => 'new'
    end
  end

  def edit
    @author = Author.find(params[:id])
  end
  
  def update
    Author.update(params[:id], params[:author])
    @author = Author.find(params[:id])
    if params[:picture][:picture].blank?
      @author.author_picture.destroy if params[:delete_author_picture] == "1"
    else
      @author.author_picture = AuthorPicture.new(params[:picture])
    end
    if @author.save
      flash[:notice] = 'Autore modificato.'
      redirect_back
    else
      render :action => 'edit'
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    redirect_back
  end
end
