class BlogController < ApplicationController
  layout "default"
  before_filter :set_section
  before_filter :authorize, :except => [ 'index', 'show' ]
  
  def set_section
    $section = "blog"
  end
  
  def index
    @recent_blog_entries = BlogEntry.find(:all, :conditions => "published = 1", :limit => 5, :order => "created_on DESC")
    @recent_comments = Comment.find(:all, :limit => 5, :conditions => "is_spam = 0", :order => "created_on DESC")
    @meta_keywords = "recensioni, libri, film, serie tv, fumetti, fantascienza, fantasy"
    @meta_description = "Recensioni di libri, film, fumetti e serie tv, con un occhio di riguardo alla fantascienza ed al fantasy"
  end
  
  def show
    begin
      @node = Node.find(params[:id])
      @page_title = @node.page_title
      @last_comments = Comment.find(:all, :conditions => "node_id = #{@node.id} AND is_spam = 0", :order =>"created_on", :limit => 3)
      session[:authorized_to_edit] = authorize_editing(@node.id)
      @meta_keywords = @node.meta_keywords
      @meta_description = @node.meta_description
    rescue
      logger.error("Attempt to access invalid review #{params[:id]}" )
      flash[:notice] = "Blgo entry non valida"
      redirect_back
    end
  end
  
  def new_step_1
    @blog_entry = BlogEntry.new
    session[:new_blog_entry] = true
  end
  
  def edit_body
    @blog_entry = BlogEntry.find(params[:id])  
  end
  
  def new_step_2
    @blog_entry = BlogEntry.find(params[:id])   
  end
  
  def create
    @blog_entry = BlogEntry.new(params[:blog_entry])            
    if session[:user_id]
      @blog_entry.user = User.find(session[:user_id])
    else
      @blog_entry.user = User.find(1)
    end
    @blog_entry.published = 0
    if @blog_entry.save
      redirect_to :action => 'new_step_2', :id => @blog_entry
    else
      render :action => 'new_step_1'
    end
  end
  
  def update_body
    @blog_entry = BlogEntry.find(params[:id])   
    if @blog_entry.update_attribute('body', params[:blog_entry][:body])
      flash[:notice] = 'Body modificato'
      redirect_back
    else
      render :action => 'edit_body', :id => @blog_entry
    end
  end
end
