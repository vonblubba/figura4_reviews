class LoginController < ApplicationController
  #before_filter :authorize, :except => :login

  layout "admin"
  
  before_filter :authorize, :except => 'login'
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy_user, :create_user, :update_user ],
         :redirect_to => { :action => :list }
  
  def index
    redirect_to(:controller => "admin" , :action => "list")
  end
  
  # just display the form and wait for user to
  # enter a name and password
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to({:controller => "review", :action => "list" })
      else
        flash[:notice] = "Invalid user/password combination"
      end
    end
  end
  
  def new_user
    @user = User.new
    @external_link = ExternalLink.new
    @avatar = Avatar.new
  end
  
  def create_user
    @user = User.new(params[:user])
    @user.external_link = ExternalLink.new(:title     => 'Homepage utente',
                                           :link_url  => params[:external_link][:link_url],
                                           :no_follow => 1) unless params[:external_link][:link_url].blank?
    @user.avatar = Avatar.new(params[:picture]) unless params[:picture][:picture].blank?                                       
    if request.post? and @user.save
      flash[:notice] = "User #{@user.name} created"
      redirect_to :action => 'list_users'
    else
      @external_link = @user.external_link
      @avatar = @user.avatar
      render :action => 'new_user'
    end
  end

  def destroy_user
    id = params[:id]
    if id && user = User.find(id)
      begin
        user.safe_delete
        flash[:notice] = "User #{user.name} deleted"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_users)
  end
  
  def list_users
    @all_users = User.find(:all)
  end

  def edit_user
    @user = User.find(params[:id])
    @avatar = @user.avatar
    @external_link = @user.external_link
  end
  
  def update_user
    User.update(params[:id], params[:user])
    @user = User.find(params[:id])
    if params[:external_link][:link_url].blank?
      @user.external_link.destroy if @user.external_link
    else
      if @user.external_link.nil?
        @user.external_link = ExternalLink.new(:title     => 'homepage utente',
                                               :link_url  => params[:external_link][:link_url],
                                               :no_follow => 1)
      else
        @user.external_link.link_url = params[:external_link][:link_url]
      end
    end
    if params[:delete_user_avatar] == "1" and not params[:delete_user_avatar].nil? 
      unless @user.avatar.nil?
        @user.avatar.destroy
      end
    else
      unless params[:picture][:picture].blank?
        unless @user.avatar.nil?
          @user.avatar.destroy 
        end
        @user.avatar = Avatar.new(params[:picture])                                       
      end
    end  
    if @user.save
      flash[:notice] = 'Utente modificato.'
      redirect_to :action => 'list_users'
    else
      @external_link = @user.external_link
      @avatar = @user.avatar
      render :action => 'edit_user'
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login" )
  end  
end
