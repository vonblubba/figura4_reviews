class ReviewController < ApplicationController
  before_filter :set_section
  before_filter :authorize, :except => [ 'index', 'list', 'show', 'search',
                                         'search_by_tag', 'show_comments', 'post_comment', 'picture']
  layout "default"
  
  def set_section
    $section = "recensioni"
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :post_comment, :update_tags ],
         :redirect_to => { :action => :list }
  
  # Sezione pubblica
  
  def index
    redirect_to :action => 'list', :order_by => 'vote'
  end
  
  def list
    conditions = "published=1 and (type='TvReview' or type='MovieReview' or type='BookReview' or type='ComicReview')"
    case params[:order_by]
      when 'vote'
        @reviews = Node.find(:all, :conditions => conditions, :order => 'vote DESC, original_title')
      when 'author'
        @authors = Author.find(:all, :order => "second_name, first_name")
        @reviews = []
        @authors.each do |a|
          revs = Node.find(:all, :conditions => 'author_id=' + a.id.to_s, :order => 'vote DESC, original_title')
          revs.each do |r|
            @reviews << r
          end
        end
      when 'media'
        @reviews = Node.find(:all, :conditions => conditions, :order => 'type, original_title')
      when 'italian_title'
        @reviews = Node.find(:all, :conditions => conditions, :order => "italian_title")
      when 'original_title'
        @reviews = Node.find(:all, :conditions => conditions, :order => "original_title")
    end
    @meta_keywords = "recensioni, libri, fumetti, serie tv, film"
    @meta_description = "Elenco delle recensioni presenti sul sito"
  end
  
  def show
    begin
      @review = Node.find(params[:id])
      @page_title = @review.page_title
      @last_comments = Comment.find(:all, :conditions => "node_id = #{@review.id} AND is_spam = 0", :order =>"created_on", :limit => 3)
      session[:authorized_to_edit] = authorize_editing(@review.id)
      @meta_keywords = @review.meta_keywords
      @meta_description = @review.meta_description
    rescue
      logger.error("Attempt to access invalid review #{params[:id]}" )
      flash[:notice] = "Recensione non valida"
      redirect_back
    end
  end
  
  def search
    begin
      @page_title = "Risultati della ricerca"
      @reviews = Review.complex_search(params[:search])
      @meta_keywords = "ricerca, recensione"
      @meta_description = "Pagina di ricerca recensione"
    rescue
      logger.error("Errore nella ricerca" )
      flash[:notice] = "Errore nella ricerca"
      redirect_back
    end
  end
  
  def search_by_tag
    begin
      @page_title = "Recensoni nella categoria '#{params[:id]}'"
      @reviews = Node.find_tagged_with(params[:id])
      @meta_keywords = "recensioni, params[:id]"
      @meta_description = "Recensioni sul tema #{params[:id]}"
    rescue
      logger.error("Errore nella ricerca per tag" )
      flash[:notice] = "Errore nella ricerca per tag"
      redirect_back
    end
  end
  
  def random_quote
    @quote = Quote.random_quote
    render(:layout => false)
  end
  
  # Sezione admin
  def new_step_1
    # Titolo + autore + media
    session[:new_review] = true
    @review = Review.new
    @page_title = "Nuova recensione - passo 1"
    @meta_keywords = "recensione"
    @meta_description = "Nuova recensione - passo 1"
  end
  
  def new_step_2
    # Trama in breve
    @review = Node.find(params[:id])
    @page_title = "Nuova recensione - passo 2"
    @meta_keywords = "recensione"
    @meta_description = "Nuova recensione - passo 2"
  end
  
  def new_step_3
    # Recensione
    @review = Node.find(params[:id])
    @page_title = "Nuova recensione - passo 3"
    @meta_keywords = "recensione"
    @meta_description = "Nuova recensione - passo 3"
  end
  
  def create
    case params[:review][:type]
      when "BookReview"
        @review = BookReview.new(params[:review])
      when "ComicReview"
        @review = ComicReview.new(params[:review])
      when "MovieReview"
        @review = MovieReview.new(params[:review])
      when "TvReview"
        @review = TvReview.new(params[:review])
    end              
    if session[:user_id]
      @review.user = User.find(session[:user_id])
    else
      @review.user = User.find(1)
    end
    @review.published = 0
    if @review.save
      redirect_to :action => 'new_step_2', :id => @review.id
    else
      render :action => 'new_step_1'
    end
  end

  def edit_plot
    @review = Node.find(params[:id])
  end
  
  def edit_review
    @review = Node.find(params[:id])
  end
  
  def edit_reference
    @review = Node.find(params[:id])
  end
  
  def edit_vote
    @review = Node.find(params[:id])
  end
  
  def edit_cover
    @review = Node.find(params[:id])
  end

  def update_plot
    @review = Node.find(params[:id])
    if @review.update_attribute('plot', params[:review][:plot])
      if session[:new_review]
        redirect_to :action => 'new_step_3', :id => @review
      else
        flash[:notice] = 'Trama modificata.'
        redirect_back
      end
    else
      render :action => 'new_step_2', :id => @review
    end
  end
  
  def update_review
    @review = Node.find(params[:id])
    if @review.update_attribute('review', params[:review][:review])
      if session[:new_review]
        flash[:notice] = 'Recensione creata'
        redirect_to :action => 'show', :id => @review
        session[:new_review] = false
      else
        flash[:notice] = 'Recensione modificata'
        redirect_back
      end
    else
      render :action => 'new_step_3', :id => @review
    end
  end
  
  def update_reference
    @review = Node.find(params[:id])
    if @review.update_attributes(params[:review])
      flash[:notice] = 'Scheda modificata'
      redirect_back
    else
      render :action => 'edit_reference', :id => @review
    end
  end
  
  def update_vote
    @review = Node.find(params[:id])
    if @review.update_attribute('vote', params[:review][:vote])
      flash[:notice] = 'Voto modificato'
      redirect_back
    else
      render :action => 'edit_vote', :id => @review
    end
  end
  
  def update_cover
    @review = Node.find(params[:id])
    if params[:picture][:picture].blank?
      @review.cover.destroy if params[:delete_cover] == "1"
    else
      @review.cover = Cover.new(params[:picture])
    end
    if @review.save
      flash[:notice] = 'Copertina modificata'
      redirect_back
    else
      render :action => 'edit_cover'
    end
  end

  def destroy
    Node.find(params[:id]).destroy
    redirect_back
  end
  
  def publish
    @review = Node.find(params[:id])
    @review.published = 1
    @review.save
    redirect_back
  end
  
  def unpublish
    @review = Node.find(params[:id])
    @review.published = 0
    @review.save
    redirect_back
  end
  
  def update_calculated_fields
    @reviews = Node.find(:all, :conditions =>'type LIKE "%Review"')
    @reviews.each do |r|
      r.update_calculated_fields
      r.save
    end
    flash[:notice] = 'update eseguito'
    redirect_to :controller => 'home'
  end
  
  def generate_urls
    @reviews = Node.find(:all, :conditions =>'type LIKE "%Review"')
    @reviews.each do |r|
      r.url = "#{r.id}-#{r.full_title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-') 
      r.save
    end
    flash[:notice] = 'url generati'
    redirect_to :controller => 'home'
  end
end
