class Comment < ActiveRecord::Base
  belongs_to              :node
  belongs_to              :user
  validates_presence_of   :body
  validates_exclusion_of  :author, :in => %w{ figura4 Figura4 admin Admin administrator Administrator root Root webmaster Webmaster }
  after_validation_on_create :set_spam_field

  def request=(request)
    self.user_ip    = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer   = request.env['HTTP_REFERER']
  end
  
  protected
  def validate
    if (user_id.nil? or user_id.blank?) and (author.nil? or author.blank?)
      errors.add_to_base("il campo autore non può essere vuoto, oppure devi essere loggato")
    end
    unless email.nil? or email.blank? or (email.include?("@") and email.include?("."))
      errors.add(:email, "non valida")
    end
  end
  
  def set_spam_field
    self.is_spam = self.check_for_spam
    comment_posted_mailer unless self.is_spam
  end
  
  def check_for_spam
    @akismet = Akismet.new('fe1bd8f73d4f', 'http://figura4.com') # blog url: e.g. http://sas.sparklingstudios.com
     
    # return true when API key isn't valid, YOUR FAULT!!
    return false unless @akismet.verifyAPIKey 
    
    # will return false, when everthing is ok and true when Akismet thinks the comment is spam. 
    return @akismet.commentCheck(
              self.user_ip,                   # remote IP
              self.user_agent,                # user agent
              self.referrer,                  # http referer
              '',                             # permalink
              'comment',                      # comment type
              self.author || self.user.name,  # author name
              '',                             # author email
              '',                             # author url
              self.body,                      # comment text
              {})                             # other
  end
  
  def comment_posted_mailer
      remainder_message = { :review_title => self.node.page_title, 
                            :nickname => self.nickname, 
                            :body => self.body, 
                            :email => self.email }
      WebsiteMailer.deliver_comment_posted(remainder_message) 
  end
  
  def before_save
    self.homepage = "http://#{self.homepage.gsub("http://", "")}" unless self.homepage.blank?
  end
end
