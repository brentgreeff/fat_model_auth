class FatModelAuthTest < ActionController::TestCase
  class ArticleController < ApplicationController
    include FatModelAuth::ControllerHelpers
    before_filter :auth_required, only: [:edit]

    attr_accessor :current_user, :article

    def edit
      render nothing: true, status: 200
    end

    def override_authority
      @article
    end

    private
    def load_article
      Article.find(params[:id])
    end
  end
end
