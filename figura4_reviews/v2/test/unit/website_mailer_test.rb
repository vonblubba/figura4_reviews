require File.dirname(__FILE__) + '/../test_helper'
require 'website_mailer'

class WebsiteMailerTest < Test::Unit::TestCase
  def setup
    @feedback_notification = { :body => "Ciao bello!",
                               :nickname => "pasqualgimmy",
                               :email => "pasqual@gimmy.it",
                               :subject => "una pirlata" }
                                             
    @comment_notification = { :review_title => "Dune", 
                              :nickname => "hasimir", 
                              :body => "Sono d'accordo", 
                              :email => "pasqual@gimmy.it" }
  end

  def test_feedback
    #emails_number = Email.find(:all).size
    response = WebsiteMailer.create_feedback(@feedback_notification)
    assert_equal("f4 reviews - una pirlata" , response.subject)
    assert_equal("oscar.riva@gmail.com" , response.to[0])
    assert_match(/Hai ricevuto un messaggio da pasqualgimmy/, response.body)
    #assert_equal(Email.find(:all).size, (emails_number + 1))
  end
  
  def test_comment_notification
    response = WebsiteMailer.create_comment_posted(@comment_notification)
    assert_equal("f4 reviews - commento postato" , response.subject)
    assert_equal("oscar.riva@gmail.com" , response.to[0])
    assert_match(/Commento postato sul sito figura4.com/, response.body)  
    assert_match(/hasimir/, response.body)
  end
end