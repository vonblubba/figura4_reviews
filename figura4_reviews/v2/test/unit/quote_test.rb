require File.dirname(__FILE__) + '/../test_helper'

class QuoteTest < Test::Unit::TestCase
  fixtures :quotes

  # Replace this with your real tests.
  def test_empty_fields
    quote = Quote.new
    assert !quote.valid?
    assert quote.errors.invalid?(:random)
    quote.random = 1
    assert !quote.valid?
    quote.original_text = "adoro i piani ben riusciti"
    assert quote.valid?
  end
end
