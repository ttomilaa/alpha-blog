require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true) 
  end
  
  test "get new article form and create article" do 
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "sports title", description: "Sports are cool"}
    end
    assert_template 'articles/show'
    assert_match "sports", response.body
  end  
  
  test "invalid article title submission results in failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_no_difference "Article.count" do
      post articles_path, article: {title: " ", description: "Sports are cool!"}
    end
    assert_template "articles/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
   test "invalid article description submission results in failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_no_difference "Article.count" do
      post articles_path, article: {title: "Sports", description: " "}
    end
    assert_template "articles/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
  test "should redirect article create when user not logged in" do
    assert_no_difference "Article.count" do
      post articles_path, article: {title: "sports", description: "Sports are cool!"}
    end
    assert_redirected_to root_path
end
end