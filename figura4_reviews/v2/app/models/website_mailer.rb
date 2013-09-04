class WebsiteMailer < ActionMailer::Base
  def feedback(message)
    @subject         = "f4 reviews - #{message[:subject]}"
    @body["message"] = message
    @recipients      = 'oscar.riva@gmail.com'
    @from            = message[:email]
    @sent_on         = Time.now
  end
  
  def comment_posted(message)
    @subject         = 'f4 reviews - commento postato'
    @body["message"] = message
    @recipients      = 'oscar.riva@gmail.com'
    @from            = message[:email]
    @sent_on         = Time.now
  end
end
