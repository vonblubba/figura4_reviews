require File.dirname(__FILE__) + '/../test_helper'
require 'admin_controller'

# Re-raise errors caught by the controller.
class AdminController; def rescue_action(e) raise e end; end

class AdminControllerTest < Test::Unit::TestCase
  fixtures :reviews

  def setup
    @controller = AdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = reviews(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:reviews)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:review)
    assert assigns(:review).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:review)
  end

  def test_create
    num_reviews = Review.count

    post :create, :review => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_reviews + 1, Review.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:review)
    assert assigns(:review).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Review.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Review.find(@first_id)
    }
  end
end
