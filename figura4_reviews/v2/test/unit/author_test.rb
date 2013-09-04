require File.dirname(__FILE__) + '/../test_helper'

class AuthorTest < Test::Unit::TestCase
  fixtures :authors

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
  
  def test_duplicate_author
    author = Author.new(:first_name => "Frank",
                        :second_name => "Herbert",
                        :bio => "schiattato")
    assert !author.valid?
  end 
end
