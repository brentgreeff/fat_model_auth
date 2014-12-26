class ArticlesController < ApplicationController
  include FatModelAuth::ControllerHelpers
  before_filter :auth_required, only: [:edit]
  attr_reader :article

  def initialize
    @article = Article.new
  end

  def edit
    render nothing: true, status: 200
  end
end
