require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < Test::Unit::TestCase
  fixtures :comments

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_empty_values
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors.invalid?(:body)
    assert comment.errors.invalid?(:author)
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
    comment.homepage = "homepagefarlocca"
    assert !comment.valid?
    assert comment.errors.invalid?(:homepage)
    comment.homepage = "homepagenonfarlocca.it"
    assert comment.valid?
  end
  
  def test_nickname
    comment = Comment.new(:body => "testo del commento",
                          :author => "the_true_figura4")
    assert !comment.valid?
    assert comment.errors.invalid?(:author)
  end
  
end
