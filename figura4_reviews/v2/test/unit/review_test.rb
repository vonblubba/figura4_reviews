require File.dirname(__FILE__) + '/../test_helper'

class ReviewTest < Test::Unit::TestCase
  fixtures :reviews, :authors, :links, :users

  def test_blank_fields
    review = BookReview.new
    assert !review.valid?
    assert review.errors.invalid?(:review)
    assert review.errors.invalid?(:vote)
    assert review.errors.invalid?(:original_title)
    assert review.errors.invalid?(:author_id)
    assert review.errors.invalid?(:published)
    review.review = "una ciofeca"
    assert !review.valid?
    assert review.errors.invalid?(:vote)
    assert review.errors.invalid?(:original_title)
    assert review.errors.invalid?(:author_id)
    assert review.errors.invalid?(:published)
    review.vote = 3
    assert !review.valid?
    assert review.errors.invalid?(:original_title)
    assert review.errors.invalid?(:author_id)
    assert review.errors.invalid?(:published)
    review.original_title = "Giovannona coscialunga"
    assert !review.valid?
    assert review.errors.invalid?(:author_id)
    assert review.errors.invalid?(:published)
    review.author = Author.find(1)
    assert !review.valid?
    assert review.errors.invalid?(:published)
    review.published = 1
    review.user = User.find(1)
    assert review.valid?
  end
  
  def test_tags
    review = BookReview.new
    review.review = "una ciofeca"
    review.vote = 3
    review.original_title = "Giovannona coscialunga"
    review.author = Author.find(1)
    review.published = 1
    review.user = User.find(1)
    review.tag_list.add("ciupaaaaa")
    assert review.valid?
    review.tag_list.add("soft sf")
    assert review.valid?
  end
  
  def test_external_links
    review = BookReview.new
    review.review = "una ciofeca"
    review.vote = 3
    review.original_title = "Giovannona coscialunga"
    review.author = Author.find(1)
    review.published = 1
    review.user = User.find(1)
    assert review.valid?
    review.links << ExternalLink.new(:title => "ciccio",
                                     :no_follow => 0,
                                     :link_url => "ciccio.it")
    assert review.valid?
    review.links << ExternalLink.new(:title => "ciccio",
                                     :no_follow => 0)
    assert !review.valid?
  end
  
  def test_internal_links
    review = BookReview.new
    review.review = "una ciofeca"
    review.vote = 3
    review.original_title = "Giovannona coscialunga"
    review.author = Author.find(1)
    review.published = 1
    review.user = User.find(1)
    assert review.valid?
    review.links << InternalLink.new(:title => "ciccio",
                                     :no_follow => 0,
                                     :controller => "review",
                                     :action => "show",
                                     :lid => "1")
    assert review.valid?
    review.links << InternalLink.new(:title => "ciccio",
                                     :no_follow => 0)
    assert !review.valid?
  end
  
  def test_quotes
    review = BookReview.new
    review.review = "una ciofeca"
    review.vote = 3
    review.original_title = "Giovannona coscialunga"
    review.author = Author.find(1)
    review.published = 1
    review.user = User.find(1)
    assert review.valid?
    review.quotes << Quote.new(:original_text => "i am an englishman in new york",
                               :author => "sting",
                               :random => 1)
    assert review.valid?
    review.quotes << Quote.new(:author => "cippalippa")
    assert !review.valid?
  end
  
  def test_comments
    review = BookReview.new
    review.review = "una ciofeca"
    review.vote = 3
    review.original_title = "Giovannona coscialunga"
    review.author = Author.find(1)
    review.published = 1
    review.user = User.find(1)
    assert review.valid?
    review.comments << Comment.new(:body => "pistongrillo",
                                   :author => "pasqualgimmy")
    assert review.valid?
    review.comments.delete_all
    review.comments << Comment.new(:author => "ciupaaaaa")
    assert !review.valid?
    review.comments.delete_all
    comment = Comment.new(:body => "pistongrillo")
    comment.user = User.find(1)
    review.comments << comment
    assert review.valid?
  end
end
