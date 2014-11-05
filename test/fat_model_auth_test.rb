require 'test_helper'

class FatModelAuthTest < ActionController::TestCase
  
  def setup
    @article = Article.new
  end

  def test_article_cannot_be_edited_by_user
    refute @article.allows(:user).to_edit?
  end

  def test_article_can_be_edited_by_admin
    assert @article.allows(:admin).to_edit?
  end

  def test_article_cannot_be_destroyed_if_its_important
    refute @article.allows(:important).to_destroy?
  end

  def test_article_can_be_destroyed_otherwise
    assert @article.allows(:boring).to_destroy?
  end
end
