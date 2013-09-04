class LoginController < ApplicationController
  before_filter :authorize, :except => :login
  layout "default"
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy_user, :create_user, :update_user ],
         :redirect_to => { :controller => 'home' }
  
  def index
    redirect_to(:controller => "login" , :action => "login")
  end
  
  # just display the form and wait for user to
  # enter a name and password
  def login
    session[:user_id] = nil
    session[:is_admin]  = nil
    session[:is_editor] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      puts user
      if user
        session[:user_id] = user.id
        session[:is_admin]  = (user.is_admin  == 1)
        session[:is_editor] = (user.is_editor == 1)
        redirect_to :controller => 'home'
      else
        flash[:notice] = "Invalid user/password combination"
      end
    end
  end
  
  def new
    @user = User.new
    @avatar = Avatar.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.avatar = Avatar.new(params[:picture]) unless params[:picture][:picture].blank?                                       
    if request.post? and @user.save
      flash[:notice] = "User #{@user.name} created"
      redirect_back
    else
      @avatar = @user.avatar
      render :action => 'new'
    end
  end

  def destroy
    id = params[:id]
    if id && user = User.find(id)
      begin
        user.safe_delete
        flash[:notice] = "User #{user.name} deleted"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_back
  end
  
  def list
    @all_users = User.find(:all)
  end

  def edit
    @user = User.find(params[:id])
    @avatar = @user.avatar
  end
  
  def update
    User.update(params[:id], params[:user])
    @user = User.find(params[:id])
    if params[:picture][:picture].blank?
      @user.avatar.destroy if params[:delete_avatar] == "1"
    else
      @user.avatar = Avatar.new(params[:picture])
    end
    if @user.save
      flash[:notice] = 'Utente modificato.'
      redirect_back
    else
      @avatar = @user.avatar
      render :action => 'edit'
    end
  end
  
  def logout
    session[:user_id] = nil
    session[:is_admin] = nil
    session[:is_editor] = nil
    flash[:notice] = "Logged out"
    redirect_back
  end  
end
