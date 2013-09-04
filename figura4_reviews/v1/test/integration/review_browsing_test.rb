require "#{File.dirname(__FILE__)}/../test_helper"

class ReviewBrowsingTest < ActionController::IntegrationTest
  fixtures :reviews
  fixtures :authors
  fixtures :points
  fixtures :comments
  fixtures :tags
  fixtures :quotes
  fixtures :users

  def test_search_for_review_and_post_comment_1
    get "/public/index"
    assert_response :success
    post_via_redirect("/public/search",
                      :search => { :key_word => "farlocca",
                                   :author_id => 1,
                                   :media => 1,
                                   :rating => 10,
                                   :tags => "",
                                   :order_by => "original_title"
                                 }
                       )
    assert_response :success
    assert_template "search"
    assert_select "table", :count => 0
    get "/public/index"
    assert_response :success
    post_via_redirect("/public/search",
                      :search => { :key_word => "dune",
                                   :author_id => 1,
                                   :media => 1,
                                   :rating => 10,
                                   :tags => "",
                                   :order_by => "original_title"
                                 }
                       )
    assert_response :success
    assert_template "search"
    assert_select "table" do
      assert_select "tr", :count => 2
    end
    get "/review/show/1"
    assert_response :success
    assert_template "show"
    post_via_redirect("/review/post_comment/1",
                      :comment => { :author => "hasimir",
                                    :body => "Figata!!!!",
                                    :email => "email@email.it",
                                    :homepage => "homepage.it"
                                  }
                       )
    assert_response :success
    assert_template "show"
  end
  
end
