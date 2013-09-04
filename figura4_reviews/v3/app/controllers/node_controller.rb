class NodeController < ApplicationController
  before_filter :authorize, :except => [ 'show_comments', 'post_comment', 'picture' ]
  layout "default"
  
  def show
    @node = Node.find(params[:id])
    if @node.is_a? Review
      redirect_to :controller => 'review', :action => 'show', :id => @node
    else
      if @node.is_a? BlogEntry
        redirect_to :controller => 'blog', :action => 'show', :id => @node
      else
        redirect_to :controller => 'home'
      end
    end
  end
  
  def publish
    @node = Node.find(params[:id])
    @node.published = 1
    @node.save
    redirect_back
  end
  
  def unpublish
    @node = Node.find(params[:id])
    @node.published = 0
    @node.save
    redirect_back
  end
  
  def edit_page_title
    @node = Node.find(params[:id])
  end
  
  def edit_meta_tags
    @node = Node.find(params[:id])
  end
  
  def edit_tags
    @node = Node.find(params[:id])
    @created_tags = Tag.new
  end
  
  def update_meta_tags
    @node = Node.find(params[:id])
    @node.meta_keywords = params[:node][:meta_keywords]
    @node.meta_description = params[:node][:meta_description]
    if @node.save
      flash[:notice] = 'Meta tags modificati'
      if session[:new_blog_entry]
        session[:new_blog_entry] = false
        redirect_to :action => 'show', :id => @node
      else
        redirect_back
      end
    else
      if session[:new_blog_entry]
        render :action => 'new_step_2', :id => @node
      else
        render :action => 'show', :id => @node
      end
    end
  end
  
  def update_tags
    @node = Node.find(params[:id])
    @node.tag_list.clear if @node.tag_list
    puts @node.tag_list
    if params[:selected_tags]
      params[:selected_tags].each do |t|
        @node.tag_list.add(t)
      end
    end
    if params[:created_tags]
      params[:created_tags].each do |t|
        @node.tag_list.add(t[:name]) unless t[:name].blank?
      end
    end
    if @node.save
      redirect_back
    else
      render :action => 'edit_tags', :id => @node
    end
  end
  
  def update_page_title
    @node = Node.find(params[:id])
    if @node.update_attribute('page_title', params[:node][:page_title])
      flash[:notice] = 'Titolo modificato'
      redirect_back
    else
      render :action => 'edit_page_title', :id => @node
    end
  end
  
  def post_comment
    begin
      @node = Node.find(params[:id])
      @new_comment = Comment.new(params[:comment])
      @new_comment.request = request
      @new_comment.node = @node
      @new_comment.user = User.find_by_id(session[:user_id])
      if @new_comment.save
        flash[:notice] = "Commento postato"
        redirect_to :action => 'show_comments', :id => @node
      else
        render :action => 'show_comments', :id => @node
      end
    rescue
      logger.error("Errore nel posting del commento" )
      flash[:notice] = "Errore nell'invio del messaggio"
      redirect_back 
    end
  end
  
  def show_comments
    begin
      @node = Node.find(params[:id])
      @page_title = @node.page_title
      session[:authorized_to_edit] = authorize_editing(@node.id)
      @meta_keywords = "#{@node.meta_keywords}, commenti"
      @meta_description = "#{@node.meta_description} - pagina dei commenti degli utenti"
    rescue
      logger.error("Attempt to access invalid review #{params[:id]}" )
      flash[:notice] = "Nodo non valido"
      redirect_back
    end
  end
  
  # da eliminare
  def temp
    @nodes = Node.find(:all)
    @nodes.each do |n| 
      n.update_calculated_fields
      unless n.save
        puts "'#{n.full_title}' by  #{n.author.full_name}"
      end
    end
    flash[:notice]='fatto!'
    redirect_to :controller => 'home', :action => 'index'
  end
end
