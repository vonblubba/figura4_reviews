require File.dirname(__FILE__) + '/../test_helper'

class AuthorTest < Test::Unit::TestCase
  fixtures :authors

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_empty_values
    author = Author.new
    assert !author.valid?
    assert author.errors.invalid?(:first_name)
    assert author.errors.invalid?(:second_name)
    author.second_name = "Saeba"
    assert !author.valid?
    assert author.errors.invalid?(:first_name)
    author.first_name = "Ryo"
    assert author.valid?
  end
  
  def test_picture_format
    author = Author.new(:first_name => "Ryo",
                        :second_name => "Saeba",
                        :bio => "Sweeper",
                        :picture => "immagine.ciupa")
    assert !author.valid?
    assert author.errors.invalid?(:picture)
    author.picture = "immagine.gif"
    assert author.valid?
    author.picture = "immagine.jpg"
    assert author.valid?
    author.picture = "immagine.jpeg"
    assert author.valid?
    author.picture = "immagine.png"
    assert author.valid?
  end
  
  def test_duplicate_author
    author = Author.new(:first_name => "Frank",
                        :second_name => "Herbert",
                        :bio => "schiattato")
    assert !author.valid?
  end 

end
