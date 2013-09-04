class AboutController < ApplicationController
  layout "review"
  before_filter :set_section
  
  def set_section
    $section = "about"
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def index
    @meta_keywords = "rails, ruby, programmazione"
    @meta_description = "Informazioni sul gestore del sito"
  end
end
