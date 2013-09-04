class CommentController < ApplicationController
  layout "admin"
  
  before_filter :authorize
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  
  def list
    @comment_pages, @comments = paginate :comments, :order => 'created_on', :conditions => ["review_id = ?", params[:id]], :per_page => 10
    @review = Review.find(params[:id])
  end

  def new
    @comment = Comment.new
    @external_link = ExternalLink.new
    @review = Review.find(params[:id])
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.review = Review.find(params[:id])
    @comment.external_link = ExternalLink.new(:title     => 'homepage del mittente',
                                              :link_url  => params[:external_link][:link_url],
                                              :no_follow => 1) unless params[:external_link].nil? or params[:external_link][:link_url].blank?
    @comment.request = request
    if @comment.save
      flash[:notice] = 'Commento aggiunto.'
      redirect_to :action => 'list', :id => params[:id]
    else
      @external_link = @comment.external_link
      @review = @comment.review
      render :action => 'new', :id => params[:id] 
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @external_link = @comment.external_link
  end

  def update
    if Comment.update(params[:id], params[:comment])
      flash[:notice] = 'Commento modificato.'
      redirect_to :action => 'list', :id => Comment.find(params[:id]).review.id
    else
      @comment = Comment.find(params[:id])
      @external_link = @comment.external_link
      @review = @comment.review
      render :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    id = @comment.review.id
    @comment.destroy
    redirect_to :action => 'list', :id => id
  end
end
