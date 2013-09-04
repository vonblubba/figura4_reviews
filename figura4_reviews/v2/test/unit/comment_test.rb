require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < Test::Unit::TestCase
  fixtures :comments, :reviews, :authors, :users

  def test_empty_values
    comment = Comment.new
    comment.review = Review.find(1)
    assert !comment.valid?
    assert comment.errors.invalid?(:body)
    comment.author = "Kaori"
    assert !comment.valid?
    assert comment.errors.invalid?(:body)
    comment.body = "Soooooka\nSooooooka"
    assert comment.valid?
    comment.email = "email.farlocca"
    assert !comment.valid?
    assert comment.errors.invalid?(:email)
    comment.email = "email@farlocca"
    assert !comment.valid?
    assert comment.errors.invalid?(:email)
    comment.email = "email.non.farlocca@tarocco.it"
    assert comment.valid?
  end
  
  def test_nickname
    comment = Comment.new(:body => "testo del commento",
                          :author => "figura4")
    assert !comment.valid?
    comment.author = "toto' riina"
    assert comment.valid?
    
    comment2 = Comment.new(:body => "testo del commento")
    comment2.user = User.find(1)
    assert comment2.valid?
  end
end
