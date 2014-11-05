require 'bundler'
Bundler.setup

require 'test/unit'
require 'mocha/setup'

require 'active_support'
require 'action_controller'

require 'fat_model_auth'

FatModelAuth::Routes = ActionDispatch::Routing::RouteSet.new
FatModelAuth::Routes.draw do
  get '/:controller(/:action(/:id))'
end

class ApplicationController < ActionController::Base
  include FatModelAuth::Routes.url_helpers
end

class ActiveSupport::TestCase
  setup do
    @routes = FatModelAuth::Routes
  end
end

require 'article'
require 'article_controller'
