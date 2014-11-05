class FatModelAuthTest < ActionController::TestCase
  class ArticleController < ApplicationController
    include FatModelAuth::ControllerHelpers
    before_filter :auth_required, only: [:edit]
    attr_reader :article

    def initialize
      @article = Article.new
    end

    def edit
      render nothing: true, status: 200
    end

    def override_authority
      @article
    end
  end
end
