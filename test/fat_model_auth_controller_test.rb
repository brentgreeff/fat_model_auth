require 'test_helper'

class FatModelAuthTest < ActionController::TestCase
  tests ArticleController

  def setup
    @article = Article.new
  end

  def test_response_when_not_logged_in
    @controller.stubs(:current_user).returns(nil)
    @controller.expects(:respond_with_404_page)
    get :edit, :id => @article.id
  end

  def test_response_when_logged_in
    @controller.stubs(:current_user).returns(:admin)
    @controller.expects(auth_required: true)
    get :edit, :id => @article.id
  end
end
