class QuoteController < ApplicationController
  layout "default"
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def new
    @quote = Quote.new
    @node = Node.find(params[:id])
  end

  def create
    @quote = Quote.new(params[:quote])
    @quote.node = Node.find(params[:id])
    if @quote.save
      flash[:notice] = 'Quote creata.'
      redirect_back
    else
      @node = @quote.node
      render :action => 'new'
    end
  end

  def edit
    @quote = Quote.find(params[:id])
  end

  def update
    if Quote.update(params[:id], params[:quote])
      flash[:notice] = 'Quote modificata.'
      redirect_back
    else
      render :action => 'edit'
    end
  end

  def destroy
    @quote = Quote.find(params[:id])
    id = @quote.node.id
    @quote.destroy
    redirect_back
  end
end
