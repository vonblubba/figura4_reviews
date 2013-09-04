require "#{File.dirname(__FILE__)}/../test_helper"

class ReviewManipulationTest < ActionController::IntegrationTest
  fixtures :authors, :users, :reviews, :links, :comments, :pictures

  def setup
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @book_review = reviews(:dune)
    @author = authors(:herbert)
  end

  def test_creating_review
    get "/author/new"
    assert_response :success
    assert_template "new"
    post_via_redirect "/author/create",
                      :author =>  { :first_name => "William",
                                    :second_name => "Gibson",
                                    :bio => "Ha inventato il cyberpunk" },
                      :picture => { :picture  => ""},
                      :link    => { :link_url => "http://puppa.it"}
    assert_response :success
    assert_template "list"
    get "/review/new"
    post_via_redirect "/review/create",
                      :review =>  { :original_title => "Neuromancer",
                                    :italian_title => "Neuromante",
                                    :author_id => Author.find_by_second_name("Gibson").id,
                                    :year => "1984",
                                    :language => "1",
                                    :pages => "412",
                                    :editor => "Nord",
                                    :vote => "10",
                                    :plot => "cowboy della console",
                                    :review => "Spettacolo!!",
                                    :published => "1", 
                                    :type => "BookReview" },
                      :picture =>   { :picture  => "" }
    assert_response :success
    assert_template "show_for_edit"
  end  
  
  def test_posting_comment
    assert_equal(reviews(:dune).id, 1)
    get "/review/show/#{reviews(:dune).id}"
    assert_response :success
    assert_template "show"
    post_via_redirect "/review/post_comment/#{reviews(:dune).id}",
                      :comment => { :body => "bella li!!",
                                    :author => "grattachecche",
                                    :email => "" },
                      :external_link => {:link_url => ""}
    assert_response :success
    assert_template "show_comments"
  end
end
