class ScreenshotController < ApplicationController
  layout "admin"
  before_filter :authorize, :except => 'picture'
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @review = Review.find(params[:id])
    @screenshots = Screenshot.find(:all, :conditions => ["review_id = ?", @review.id])
  end

  def new
    @screenshot = Screenshot.new
    @review = Review.find(params[:id])
  end

  def create
    @screenshot = Screenshot.new(params[:screenshot])
    @screenshot.review = Review.find(params[:id])
    @screenshot.picture = params[:picture][:picture] unless params[:picture][:picture].blank?
    if @screenshot.save
      flash[:notice] = 'Screenshot creato.'
      redirect_to :action => 'list', :id => @screenshot.review.id
    else
      @review = @screenshot.review
      render :action => 'new'
    end
  end

  def edit
    @screenshot = Screenshot.find(params[:id])
  end

  def update
    Screenshot.update(params[:id], params[:screenshot])
    @screenshot = Screenshot.find(params[:id])
    @screenshot.picture = params[:picture][:picture] unless params[:picture][:picture].blank?
    if @screenshot.save
      flash[:notice] = 'Screenshot modificato.'
      redirect_to :action => 'list', :id => @screenshot.review.id
    else
      @review = @screenshot.review
      render :action => 'edit'
    end
  end

  def destroy
    @screenshot = Screenshot.find(params[:id])
    id = @screenshot.review.id
    @screenshot.destroy
    redirect_to :action => 'list', :id => id
  end
end
