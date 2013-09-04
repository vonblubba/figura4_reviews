class AdminController < ApplicationController
  
  before_filter :authorize
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @review_pages, @reviews = paginate :reviews, :order => 'original_title', :per_page => 20
  end
  
  def list_authors
    @author_pages, @authors = paginate :authors, :order => 'second_name', :per_page => 20
  end
  
  def list_pages
    @page_pages, @pages = paginate :pages, :order => 'title', :per_page => 20
  end
  
  def list_quotes
    @quote_pages, @quotes = paginate :quotes, :order => 'id', :conditions => ["review_id = ?", params[:id]], :per_page => 10
    @review = Review.find(params[:id])
  end
  
  def list_comments
    @comment_pages, @comments = paginate :comments, :order => 'created_on', :conditions => ["review_id = ?", params[:id]], :per_page => 10
    @review = Review.find(params[:id])
  end

  def show
    @review = Review.find(params[:id])
  end
  
  def show_author
    @author = Author.find(params[:id])
  end

  def show_page
    @page = Page.find(params[:id])
  end

  def new
    @review = Review.new
    @authors = Author.list_for_select
  end
  
  def new_author
    @author = Author.new
  end

  def new_page
    @page = Page.new
  end  
  
  def new_quote
    @quote = Quote.new
    @review = Review.find(params[:id])
  end
  
  def new_comment
    @comment = Comment.new
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(params[:review])
    @review.cover = Review.save_cover(params[:picture])
    @review.user = User.find(session[:user_id])
    if @review.save
      flash[:notice] = 'Recensione creata.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  
  def create_author
    @author = Author.new(params[:author])
    @author.picture = Author.save_picture(params[:picture])
    if @author.save
      flash[:notice] = 'Autore creato.'
      redirect_to :action => 'list_authors'
    else
      render :action => 'new_author'
    end
  end

  def create_page
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = 'Pagina creata.'
      redirect_to :action => 'list_pages'
    else
      render :action => 'new_page'
    end
  end

  
  def create_quote
    @quote = Quote.new(params[:quote])
    @quote.review = Review.find(params[:id])
    if @quote.save
      flash[:notice] = 'Quote creata.'
      redirect_to :action => 'list_quotes', :id => params[:id]
    else
      render :action => 'new_quote'
    end
  end

  def create_comment
    @comment = Comment.new(params[:comment])
    @comment.review = Review.find(params[:id])
    if @comment.save
      flash[:notice] = 'Commento aggiunto.'
      redirect_to :action => 'list_comments', :id => params[:id]
    else
      render :action => 'new_comment'
    end
  end

  def edit
    @review = Review.find(params[:id])
  end
  
  def edit_author
    @author = Author.find(params[:id])
  end
  
  def edit_page
    @page = Page.find(params[:id])
  end
  
  def edit_quote
    @quote = Quote.find(params[:id])
  end

  def edit_comment
    @comment = Comment.find(params[:id])
  end
  
  def edit_tags
    @review = Review.find(params[:id])
    @all_tags = Tag.find(:all, :order => "name" ).map {|t| [t.name, t.id] }
  end

  def update
    @review = Review.find(params[:id])
    render :action => 'edit' unless @review.update_attributes(params[:review])
    @review.cover = Review.save_cover(params[:picture]) unless params[:picture][:picture].nil? or params[:picture][:picture].blank?
    if @review.save
      flash[:notice] = 'Recensione modificata.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end
  
  def update_author
    Author.update(params[:id], params[:author])
    @author = Author.find(params[:id])
    @author.picture = Author.save_picture(params[:picture]) unless params[:picture][:picture].nil? or params[:picture][:picture].blank?
    if @author.save
      flash[:notice] = 'Autore modificato.'
      redirect_to :action => 'list_authors'
    else
      render :action => 'edit_author'
    end
  end
  
  def update_page
    if Page.update(params[:id], params[:page])
      flash[:notice] = 'Pagina modificata.'
      redirect_to :action => 'list_pages'
    else
      render :action => 'edit_page'
    end
  end
  
  def update_quote
    if Quote.update(params[:id], params[:quote])
      flash[:notice] = 'Quote modificata.'
      redirect_to :action => 'list_quotes', :id => Quote.find(params[:id]).review.id
    else
      render :action => 'edit_quote'
    end
  end

  def update_comment
    if Comment.update(params[:id], params[:comment])
      flash[:notice] = 'Commento modificato.'
      redirect_to :action => 'list_comments', :id => Comment.find(params[:id]).review.id
    else
      render :action => 'edit_comment'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.quotes.delete_all
    File.delete("public/images/covers/" + @review.cover) if File.exist?("public/images/covers/" + @review.cover)
    @review.destroy
    redirect_to :action => 'list'
  end
  
  def destroy_author
    @author = Author.find(params[:id])
    @author.destroy
    redirect_to :action => 'list_authors'
  end
  
  def destroy_page
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to :action => 'list_pages'
  end
  
  def destroy_quote
    @quote = Quote.find(params[:id])
    id = @quote.review.id
    @quote.destroy
    redirect_to :action => 'list_quotes', :id => id
  end
  
  def destroy_comment
    @comment = Comment.find(params[:id])
    id = @comment.review.id
    @comment.destroy
    redirect_to :action => 'list_comments', :id => id
  end
  
  def update_tags
    @review = Review.find(params[:id])
    @review.update_tags(params)
    redirect_to :action => 'list'
  end
  
end
