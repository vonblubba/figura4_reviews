require File.dirname(__FILE__) + '/../test_helper'
require 'review_controller'

# Re-raise errors caught by the controller.
class ReviewController; def rescue_action(e) raise e end; end

class ReviewControllerTest < Test::Unit::TestCase
  fixtures :authors, :users, :reviews, :links, :comments, :pictures
  
  def setup
    @controller = ReviewController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @emails = ActionMailer::Base.deliveries
    @emails.clear
  end

  def test_post_comment
    post(:post_comment, { :id => 1, 
                         :comment => { :body => "bella li!!",
                                       :author => "grattachecche",
                                       :email => "" },
                         :external_link => {:link_url => "" } } )
    assert_redirected_to(:action => :show_comments)
    assert_equal(1, @emails.size)
    email = @emails.first
    assert_equal("f4 reviews - commento postato" , email.subject)
    assert_equal("oscar.riva@gmail.com" , email.to[0])
    assert_match(/Commento postato sul sito figura4.com/, email.body)
  end
end
