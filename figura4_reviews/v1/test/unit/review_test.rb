require File.dirname(__FILE__) + '/../test_helper'

class ReviewTest < Test::Unit::TestCase
  fixtures :reviews
  fixtures :authors
  fixtures :points
  fixtures :comments
  fixtures :tags
  fixtures :quotes
  fixtures :users

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_blank_required_fields
    review = Review.new
    assert !review.valid?
    assert review.errors.invalid?(:review)
    assert review.errors.invalid?(:vote)
    assert review.errors.invalid?(:media)
    assert review.errors.invalid?(:original_title)
    assert review.errors.invalid?(:author_id)
    assert review.errors.invalid?(:user_id)
    review.review = "una ciofeca"
    assert !review.valid?
    assert review.errors.invalid?(:vote)
    assert review.errors.invalid?(:media)
    assert review.errors.invalid?(:original_title)
    assert review.errors.invalid?(:author_id)
    assert review.errors.invalid?(:user_id)
    review.vote = 10
    assert !review.valid?
    assert review.errors.invalid?(:media)
    assert review.errors.invalid?(:original_title)
    assert review.errors.invalid?(:author_id)
    assert review.errors.invalid?(:user_id)
    review.is_book = 1
    assert !review.valid?
    assert review.errors.invalid?(:original_title)
    assert review.errors.invalid?(:author_id)
    assert review.errors.invalid?(:user_id)
    review.original_title = "il titolo"
    assert !review.valid?
    assert review.errors.invalid?(:author_id)
    assert review.errors.invalid?(:user_id)
    review.author_id = 1
    assert !review.valid?
    assert review.errors.invalid?(:user_id)
    review.user_id = 1
    assert review.valid?
  end
  
  def test_numericality_of_vote
    review = Review.new(:original_title => "Titolo originale",
                        :vote           => "ciupa",
                        :author_id      => 1,
                        :user_id        => 1,
                        :review         => "azz",
                        :media        => 0)
    assert !review.valid?
    assert review.errors.invalid?(:vote)
    review.vote = 2
    assert review.valid?
  end
  
  def test_cover_image_format
    review = Review.new(:original_title => "Titolo originale",
                        :vote           => 2,
                        :author_id      => 1,
                        :user_id        => 1,
                        :review         => "azz",
                        :media        => 0,
                        :cover          => "cover.ciupa")
    assert !review.valid?
    assert review.errors.invalid?(:cover)
    review.cover = "cover.jpg"
    assert review.valid?
    review.cover = "cover.jpeg"
    assert review.valid?
    review.cover = "cover.gif"
    assert review.valid?
    review.cover = "cover.png"
    assert review.valid?
  end
  
end
