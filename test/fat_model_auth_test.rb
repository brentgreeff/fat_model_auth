require 'test_helper'

class FatModelAuthTest < Minitest::Test
  class Article
    extend ::FatModelAuth::ModelHelpers

    allows :edit, if: proc { |article, user| user == :author }
    allows :destroy, unless: proc { |article, user| not user == :admin }
  end

  def setup
    @article = Article.new
  end

  def test_unless
    refute @article.allows(:author).to_destroy?
    assert @article.allows(:admin).to_destroy?
  end

  def test_if
    assert @article.allows(:author).to_edit?
    refute @article.allows(:admin).to_edit?
  end
end
