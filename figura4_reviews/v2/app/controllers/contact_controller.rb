class ContactController < ApplicationController
  layout "review"
  before_filter :set_section
  
  def set_section
    $section = "contacts"
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  def index
    @meta_keywords = "contacts, feedback"
    @meta_description = "Form per contattare il gestore del sito"
  end
  
  def feedback
    #begin
      unless params[:feedback][:nickname].blank? or params[:feedback][:email].blank? or params[:feedback][:body].blank?
        WebsiteMailer.deliver_feedback(params[:feedback])
        Email.create(:sender => params[:feedback][:nickname],
                     :sender_address => params[:feedback][:email],
                     :body => params[:feedback][:body],
                     :is_spam => 0)
        flash[:notice] = "Messaggio inviato."
        redirect_to(:action => 'index')
      else
        flash[:notice] = "Tutti i campi sono obbligatori"
        redirect_to(:action => 'index')
      end
    #rescue
    #  flash[:notice] = "Si è verificato un errore. Messaggio non inviato."
    #  render :action => 'index'
    #end
  end
end
