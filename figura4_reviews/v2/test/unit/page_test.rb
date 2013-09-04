require File.dirname(__FILE__) + '/../test_helper'

class PageTest < Test::Unit::TestCase
  fixtures :pages

  def test_blank_fields
    page = Page.new
    assert !page.valid?
    assert page.errors.invalid?(:title)
    assert page.errors.invalid?(:html_body)
    assert page.errors.invalid?(:meta_description)
    assert page.errors.invalid?(:meta_keywords)
    assert page.errors.invalid?(:published)
    assert page.errors.invalid?(:user_id)
    assert page.errors.invalid?(:description)
    page.title = "Il ritorno di Don Camillo"
    assert !page.valid?
    assert page.errors.invalid?(:html_body)
    assert page.errors.invalid?(:meta_description)
    assert page.errors.invalid?(:meta_keywords)
    assert page.errors.invalid?(:published)
    assert page.errors.invalid?(:user_id)
    assert page.errors.invalid?(:description)
    page.html_body = "<body>miiiiinkia</body>"
    assert !page.valid?
    assert page.errors.invalid?(:meta_description)
    assert page.errors.invalid?(:meta_keywords)
    assert page.errors.invalid?(:published)
    assert page.errors.invalid?(:user_id)
    assert page.errors.invalid?(:description)
    page.meta_description = "peppone e dc se le danno"
    assert !page.valid?
    assert page.errors.invalid?(:meta_keywords)
    assert page.errors.invalid?(:published)
    assert page.errors.invalid?(:user_id)
    assert page.errors.invalid?(:description)
    page.meta_keywords = "camillo, peppone"
    assert !page.valid?
    assert page.errors.invalid?(:published)
    assert page.errors.invalid?(:user_id)
    assert page.errors.invalid?(:description)
    page.published = 1
    assert !page.valid?
    assert page.errors.invalid?(:user_id)
    assert page.errors.invalid?(:description)
    page.user = User.find(1)
    assert !page.valid?
    assert page.errors.invalid?(:description)
    page.description = "della gran fuffa"
    assert page.valid?
  end
end
