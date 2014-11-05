require 'test_helper'

class FatModelAuthTest < ActionController::TestCase
  tests ArticleController

  def setup
    @article = Article.new
  end

  def test_response_when_not_logged_in
    @controller.stubs(:current_user).returns(nil)
    @controller.expects(:respond_with_404_page)
    get :edit, id: @article.id
  end

  def test_response_when_logged_in
    @controller.stubs(:current_user).returns(:admin)
    @controller.expects(auth_required: true)
    get :edit, id: @article.id
  end

  def test_canned_gate_keeper_logged_in_allowed
    @controller.stubs(:current_user).returns(:admin)
    @controller.article.expects(:allows).returns(FatModelAuth::CannedGateKeeper.allows(:edit))
    get :edit, id: @article.id
  end

  def test_canned_gate_keeper_when_logged_in
    @controller.stubs(:current_user).returns(:user)
    @controller.article.expects(:allows).returns(FatModelAuth::CannedGateKeeper.denies(:edit))
    get :edit, id: @article.id
  end
end
