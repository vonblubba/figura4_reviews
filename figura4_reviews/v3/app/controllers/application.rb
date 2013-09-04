# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '777aedc1a9f0249e1157065b3cf963b7'
  before_filter :link_return
  
  def picture
    @picture = Picture.find(params[:id])
    send_data(@picture.data,
              :filename => @picture.name,
              :type => @picture.content_type,
              :disposition => "inline" )
  end
  
  def back
    redirect_back
  end

  private
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_url] = request.request_uri
      session[:authorized_to_edit] = false
      flash[:notice] = "Effettuare il login | Please log in"
      redirect_to(:controller => "login" , :action => "login" )
    end
  end
  
  def authorize_editing(node_id)
    @user = User.find_by_id(session[:user_id])
    @node = Node.find(node_id)
    if @user and ((@node.user == @user and @user.is_editor == 1) or @user.is_admin == 1)
      true
    else
      false
    end
  end
  
  def link_return
    if params[:return_uri]
      session[:original_uri] = params[:return_uri]
    end
  end
  
  def redirect_back(*params)
    uri = session[:original_uri]
    session[:original_uri] = nil
    if uri
      redirect_to uri
    else
      redirect_to(*params)
    end
  end
end
