require File.dirname(__FILE__) + '/../test_helper'

class ExternalLinkTest < Test::Unit::TestCase
  def test_general_link
    link = ExternalLink.new
    link.in_link_section = 1
    assert !link.valid?
    assert link.errors.invalid?(:title)
    assert link.errors.invalid?(:no_follow)
    assert link.errors.invalid?(:link_url)
    link.title = "scifi channel"
    assert !link.valid?
    assert link.errors.invalid?(:no_follow)
    assert link.errors.invalid?(:link_url)
    link.no_follow = 1
    assert !link.valid?
    assert link.errors.invalid?(:link_url)
    link.link_url = "http://www.puppa.it"
    assert link.valid?
  end
end