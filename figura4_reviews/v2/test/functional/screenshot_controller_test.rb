require File.dirname(__FILE__) + '/../test_helper'
require 'screenshot_controller'

# Re-raise errors caught by the controller.
class ScreenshotController; def rescue_action(e) raise e end; end

class ScreenshotControllerTest < Test::Unit::TestCase
  def setup
    @controller = ScreenshotController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
