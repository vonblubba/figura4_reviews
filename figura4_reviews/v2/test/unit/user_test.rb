require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  fixtures :users, :links

  def test_blank_fields
    user = User.new
    assert !user.valid?
    assert user.errors.invalid?(:name)
    assert user.errors.invalid?(:password)
    user.name = "figura4"
    assert !user.valid?
    assert user.errors.invalid?(:name)
    assert user.errors.invalid?(:password)
    user.name = "il rinko"
    assert !user.valid?
    assert user.errors.invalid?(:password)
    user.password = "1"
    assert !user.valid?
    assert user.errors.invalid?(:password)
    user.password = "hdtduuis73h2j!"
    assert !user.valid?
    user.password_confirmation = "hdtduuis73h2j!"
    assert user.valid?
  end
  
  def test_homepage
    user = User.new
    user.name = "il rinko"
    user.password = "1"
    user.password = "hdtduuis73h2j!"
    user.password_confirmation = "hdtduuis73h2j!"
    user.external_link = ExternalLink.find(1)
    assert user.valid?
    link = ExternalLink.new
    user.external_link = link
    assert !user.valid?
    user.external_link.title = "sta ceppa"
    assert !user.valid?
    user.external_link.no_follow = 0
    assert !user.valid?
    user.external_link.link_url = "staceppa.com"
    assert user.valid?
  end
end
