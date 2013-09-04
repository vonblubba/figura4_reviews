class ReviewController < ApplicationController
  before_filter :set_section
  before_filter :authorize, :except => [ 'index', 'list_by_vote', 'show', 'list_by_author',
                                         'list_by_media', 'list_by_title', 'list_by_original_title', 'search',
                                         'search_by_tag', 'show_comments', 'post_comment', 'picture']
  
  def set_section
    $section = "recensioni"
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :post_comment, :update_tags ],
         :redirect_to => { :action => :list }
  
  # Sezione pubblica
    
  def index
    redirect_to :action => 'list_by_vote'
  end
    
  def list_by_vote
    @reviews = Review.find(:all, :conditions => "published=1", :order => 'vote DESC, original_title')
    @meta_keywords = "recensioni, libri, fumetti, serie tv, film"
    @meta_description = "Elenco delle recensioni del sito, ordinate per votazione decrescente"
  end
  
  def list_by_author
    @authors = Author.find(:all, :order => "second_name, first_name")
    @reviews = []
    @authors.each do |a|
      a.reviews.each do |r|
        @reviews << r
      end
    end
    @meta_keywords = "recensioni, libri, fumetti, serie tv, film"
    @meta_description = "Elenco delle recensioni del sito, ordinate per autore"
  end
  
  def list_by_media
    @reviews = Review.find(:all, :conditions => "published=1", :order => 'type, original_title')
    @meta_keywords = "recensioni, libri, fumetti, serie tv, film"
    @meta_description = "Elenco delle recensioni del sito, ordinate per tipo"
  end
  
  def list_by_title
    @reviews = Review.find(:all, :conditions => "published=1", :order => "italian_title")
    @meta_keywords = "recensioni, libri, fumetti, serie tv, film"
    @meta_description = "Elenco delle recensioni del sito, ordinate per titolo"
  end
  
  def list_by_original_title
    @reviews = Review.find(:all, :conditions => "published=1", :order => "original_title")
    @original_title = 1
    @meta_keywords = "recensioni, libri, fumetti, serie tv, film"
    @meta_description = "Elenco delle recensioni del sito, ordinate per titolo originale"
  end
  
  def show
    begin
      @review = Review.find(params[:id])
      @page_title = @review.page_title
      @last_comments = Comment.find(:all, :conditions => "review_id = #{@review.id} AND is_spam = 0", :order =>"created_on", :limit => 3)
      @meta_keywords = @review.meta_keywords
      @meta_description = @review.meta_description
    rescue
      logger.error("Attempt to access invalid review #{params[:id]}" )
      flash[:notice] = "Recensione non valida"
      redirect_to :controller => 'home', :action => :index
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
      redirect_to :action => :index
    end
  end
  
  def search_by_tag
    begin
      @page_title = "Recensoni nella categoria '#{params[:id]}'"
      @reviews = Review.find_tagged_with(params[:id])
      @meta_keywords = "recensioni, params[:id]"
      @meta_description = "Recensioni sul tema #{params[:id]}"
    rescue
      logger.error("Errore nella ricerca per tag" )
      flash[:notice] = "Errore nella ricerca per tag"
      redirect_to :action => :index
    end
  end
  
  def show_comments
    begin
      @review = Review.find(params[:id])
      @page_title = @review.page_title
      @meta_keywords = "#{@review.meta_keywords}, commenti"
      @meta_description = "#{@review.meta_description} - pagina dei commenti degli utenti"
    rescue
      logger.error("Attempt to access invalid review #{params[:id]}" )
      flash[:notice] = "Recensione non valida"
      redirect_to :action => :index
    end
  end
  
  def post_comment
    begin
      @review = Review.find(params[:id])
      @new_comment = Comment.new(params[:comment])
      @new_comment.request = request
      @new_comment.review = @review
      @new_comment.user = User.find_by_id(session[:user_id])
      @new_comment.save
      remainder_message = { :review_title => @review.full_title, 
                            :nickname => params[:comment][:nickname], 
                            :body => params[:comment][:body], 
                            :email => params[:comment][:email] }
      WebsiteMailer.deliver_comment_posted(remainder_message) if @new_comment.is_spam == 0
      redirect_to :action => 'show_comments', :id => @review 
    rescue
      logger.error("Errore nel posting del commento" )
      flash[:notice] = "Errore nell'invio del messaggio"
      render :action => 'show_comments', :id => @review  
    end
  end
  
  # Sezione admin
  def list
    @review_pages, @reviews = paginate :reviews, :order => 'original_title', :per_page => 20
    render :layout => 'admin'
  end

  def new
    @review = Review.new
    render :layout => 'admin'
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
    @review.cover = Cover.new(params[:picture]) unless (params[:picture][:picture].blank? or params[:picture].nil?)                                       
    if session[:user_id]
      @review.user = User.find(session[:user_id])
    else
      @review.user = User.find_by_name("figura4")
    end
    if @review.save
      flash[:notice] = 'Recensione creata.'
      redirect_to :action => 'show_for_edit', :id => @review, :type => @review.class
    else
      render :action => 'new', :layout => 'admin'
    end
  end

  def edit
    @review = Review.find(params[:id])
    render :layout => 'admin'
  end

  def edit_links
    @review = Review.find(params[:id])
    @external_links = ExternalLink.find(:all, :conditions => ["review_id = ?", @review.id])
    @internal_links = InternalLink.find(:all, :conditions => ["review_id = ?", @review.id])
    render :layout => 'admin'
  end
  
  def edit_tags
    @review = Review.find(params[:id])
    render :layout => 'admin'
  end

  def update
    @review = Review.find(params[:id])
    @review.update_attributes(params[:review])
    @review.type = params[:review][:type]
    if params[:delete_cover] == "1" and not params[:delete_cover].nil? 
      unless @review.cover.nil?
        @review.cover.destroy
      end
    else
      unless params[:picture][:picture].blank?
        unless @review.cover.nil?
          @review.cover.destroy 
        end
        @review.cover = Cover.new(params[:picture])                                       
      end
    end  
    if @review.save
      flash[:notice] = 'Recensione modificata.'
      redirect_to :action => 'show_for_edit', :id => @review, :type => @review.class
    else
      render :action => 'edit', :layout => 'admin'
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def show_for_edit
    @review = Review.find(params[:id])
    render :layout => 'admin'
  end
  
  def update_tags
    @review = Review.find(params[:id])
    @review.tag_list.clear
    if params[:tags]
      params[:tags].each do |t|
        @review.tag_list.add(t)
      end
    end
    if params[:create_tag]
      params[:create_tag].each do |t|
        @review.tag_list.add(t[:name]) unless t[:name].blank?
      end
    end
    @review.save
    redirect_to :action => 'show_for_edit', :id => params[:id], :type => @review.class
  end
end
