class ReviewMailer < ActionMailer::Base

  def feedback(message)
    @subject         = 'Feedback da figura4.com'
    @body["message"] = message
    @recipients      = 'oscar.riva@gmail.com'
    @from            = message[:email]
    @sent_on         = Time.now
  end
  
  def comment_posted(message)
    @subject         = 'Commento postato su figura4.com'
    @body["message"] = message
    @recipients      = 'oscar.riva@gmail.com'
    @from            = message[:email]
    @sent_on         = Time.now
  end
  
end
