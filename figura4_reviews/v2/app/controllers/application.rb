# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_figura4_v2_session_id'
  $section = "home"
  
  def picture
    @picture = Picture.find(params[:id])
    send_data(@picture.data,
              :filename => @picture.name,
              :type => @picture.content_type,
              :disposition => "inline" )
  end

  private
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_url] = request.request_uri
      flash[:notice] = "Please log in"
      redirect_to(:controller => "login" , :action => "login" )
    end
  end
end
