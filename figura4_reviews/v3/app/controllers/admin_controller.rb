class AdminController < ApplicationController
  before_filter :authorize, :except => 'index'
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def index
    redirect_to :controller => 'login', :action => 'login'
  end
  
  def backup_db

  end
end
