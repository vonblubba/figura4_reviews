class QuoteController < ApplicationController
  layout "admin"
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def list
    @quote_pages, @quotes = paginate :quotes, :order => 'id', :conditions => ["review_id = ?", params[:id]], :per_page => 10
    @review = Review.find(params[:id])
  end

  def new
    @quote = Quote.new
    @review = Review.find(params[:id])
  end

  def create
    @quote = Quote.new(params[:quote])
    @quote.review = Review.find(params[:id])
    if @quote.save
      flash[:notice] = 'Quote creata.'
      redirect_to :action => 'list', :id => params[:id]
    else
      @review = @quote.review
      render :action => 'new'
    end
  end

  def edit
    @quote = Quote.find(params[:id])
  end

  def update
    if Quote.update(params[:id], params[:quote])
      flash[:notice] = 'Quote modificata.'
      redirect_to :action => 'list', :id => Quote.find(params[:id]).review.id
    else
      render :action => 'edit'
    end
  end

  def destroy
    @quote = Quote.find(params[:id])
    id = @quote.review.id
    @quote.destroy
    redirect_to :action => 'list', :id => id
  end
end
