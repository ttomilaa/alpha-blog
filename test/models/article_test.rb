require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new(title: "new title", description: "desctiption for test article", user_id: "4")
  end
  
  test "article should be valid" do
    assert @article.valid?
  end
  
  test "title should be present" do
    @article.title = ""
    assert_not @article.valid?
  end
  
  test "description should be present" do 
    @article.description = ""
    assert_not @article.valid?
  end
  
  test "user_id should be present" do
    @article.user_id = ""
    assert_not @article.valid?
  end
  
 test "title should not be too long" do
    @article.title = "a" * 51
    assert_not @article.valid?
  end

  test "title should not be too small" do
    @article.title = "aa"
    assert_not @article.valid?
  end

  test "description should not be too long" do
    @article.description = "a" * 301
    assert_not @article.valid?
  end

  test "description should not be too small" do
    @article.description = "aa"
    assert_not @article.valid?
  end    
end