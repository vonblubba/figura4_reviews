class ReviewController < ApplicationController
  
  def index
    @last_reviews = Review.find(:all, :conditions => "published = 1", :limit => 5, :order => "created_on DESC")
    @page_name = "home"
  end
  
  def show
    begin
      @page_name = "sitemap"
      @review = Review.find(params[:id])
      @page_title = @review.page_title
      @last_comments = Comment.find(:all, :conditions => "review_id = #{@review.id}", :order =>"created_on", :limit => 3)
    rescue
      logger.error("Attempt to access invalid review #{params[:id]}" )
      flash[:notice] = "Recensione non valida"
      redirect_to :action => :index
    end
  end
  
  def search
    begin
      @page_name = "sitemap"
      @page_title = "Risultati della ricerca"
      @reviews = Review.complex_search(params[:search])
    rescue
      logger.error("Errore nella ricerca" )
      flash[:notice] = "Errore nella ricerca"
      redirect_to :action => :index
    end
  end
  
  def search_by_tag
    begin
      @page_title = "Recensoni nella categoria '" + Tag.find(params[:id]).name + "'"
      @review_pages, @reviews = paginate :reviews, :order => 'vote DESC', :per_page => 10, :conditions => ["published = 1 AND id IN (SELECT review_id FROM reviews_tags WHERE tag_id = ?)", params[:id]]
    rescue
      logger.error("Errore nella ricerca per tag" )
      flash[:notice] = "Errore nella ricerca per tag"
      redirect_to :action => :index
    end
  end
  
  def post_comment
    begin
      @review = Review.find(params[:id])
      unless check_comment_for_spam(params[:comment][:nickname], params[:comment][:body])
        @review.post_comment(params[:comment])
      end 
      remainder_message = {:review_title => @review.full_title_to_display, :nickname => params[:comment][:nickname], :body => params[:comment][:body], :email => params[:comment][:email]}
      ReviewMailer.deliver_comment_posted(remainder_message)
      redirect_to :action => 'show_comments', :id => @review
    rescue
      logger.error("Errore nel posting del commento" )
      flash[:notice] = "Errore nell'invio del messaggio"
      redirect_to :action => 'show', :id => @review  
    end
  end
  
  def contacts
    @page_name = "contacts"
  end
  
  def about_me
    @page_name = "about me"
  end
  
  def links
    @page_name = "links"
  end
  
  def sitemap
    @page_name = "sitemap"
    @reviews_10 = Review.find(:all, :conditions => "vote=10", :order => 'original_title')
    @reviews_9 = Review.find(:all, :conditions => "vote=9", :order => 'original_title')
    @reviews_8 = Review.find(:all, :conditions => "vote=8", :order => 'original_title')
    @reviews_7 = Review.find(:all, :conditions => "vote=7", :order => 'original_title')
    @reviews_6 = Review.find(:all, :conditions => "vote=6", :order => 'original_title')
    @reviews_5 = Review.find(:all, :conditions => "vote=5", :order => 'original_title')
    @reviews_4 = Review.find(:all, :conditions => "vote=4", :order => 'original_title')
    @reviews_3 = Review.find(:all, :conditions => "vote=3", :order => 'original_title')
    @reviews_2 = Review.find(:all, :conditions => "vote=2", :order => 'original_title')
    @reviews_1 = Review.find(:all, :conditions => "vote=1", :order => 'original_title')
    @reviews_0 = Review.find(:all, :conditions => "vote=0", :order => 'original_title')
  end
  
  def show_comments
    begin
      @page_name = "sitemap"
      @review = Review.find(params[:id])
      @comments = Comment.find_by_review_id(@review.id)
      @page_title = Review.find(params[:id]).page_title
    rescue
      logger.error("Attempt to access invalid review #{params[:id]}" )
      flash[:notice] = "Recensione non valida"
      redirect_to :action => :index
    end
  end
  
  def feedback
    begin
      unless params[:feedback][:nickname].blank? or params[:feedback][:email].blank? or params[:feedback][:body].blank?
        ReviewMailer.deliver_feedback(params[:feedback])
        flash[:notice] = "Messaggio inviato."
        redirect_to(:action => 'contacts')
      else
        flash[:notice] = "Tutti i campi sono obbligatori"
        redirect_to(:action => 'contacts')
      end
    rescue
      flash[:notice] = "Si è verificato un errore. Messaggio non inviato."
      render :action => 'contacts'
    end
  end
  
  def redirect_to_home
    headers["Status"] = "301 Moved Permanently"
    redirect_to "/"
  end
  
  protected
  def check_comment_for_spam(author, text)
    @akismet = Akismet.new('fe1bd8f73d4f', 'http://www.figura4.com') # blog url: e.g. http://sas.sparklingstudios.com
     
    # return true when API key isn't valid, YOUR FAULT!!
    return true unless @akismet.verifyAPIKey 
    
    # will return false, when everthing is ok and true when Akismet thinks the comment is spam. 
    return @akismet.commentCheck(
              request.remote_ip,            # remote IP
              request.user_agent,           # user agent
              request.env['HTTP_REFERER'],  # http referer
              '',                           # permalink
              'comment',                    # comment type
              author,                       # author name
              '',                           # author email
              '',                           # author url
              text,                         # comment text
              {})                           # other
  end
  
end
