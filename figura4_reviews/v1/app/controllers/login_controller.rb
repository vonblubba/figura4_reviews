class LoginController < ApplicationController
  before_filter :authorize, :except => :login

  layout "admin"
  
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
        redirect_to(session[:original_url] || { :action => "index" })
      else
        flash[:notice] = "Invalid user/password combination"
      end
    end
  end
  
  def add_user
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash[:notice] = "User #{@user.name} created"
      @user = User.new
    end
  end

  def delete_user
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
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login" )
  end
  
end
