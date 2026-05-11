# frozen_string_literal: true

require 'spec_helper'
require 'action_controller'
require 'fat_model_auth/controller_helpers'
require 'fat_model_auth/canned_gate_keeper'

# PORO article — no database needed for controller specs
class AuthTestArticle
  extend FatModelAuth::ModelHelpers

  attr_accessor :id

  def initialize(id = 1)
    @id = id
  end

  allows :edit,    if:     ->(_article, user) { user == :admin }
  allows :destroy, unless: ->(_article, user) { user == :peon }
end

AuthTestRoutes = ActionDispatch::Routing::RouteSet.new
AuthTestRoutes.draw do
  get 'articles/:id/edit',    to: 'auth_test_articles#edit', as: :edit_article
  delete 'articles/:id',      to: 'auth_test_articles#destroy', as: :article
end

class AuthTestArticlesController < ActionController::Base
  include AuthTestRoutes.url_helpers
  include FatModelAuth::ControllerHelpers

  before_action :load_article
  before_action :auth_required, only: %i[edit destroy]

  def edit
    head :ok
  end

  def destroy
    head :ok
  end

  private

  def load_article
    @article = AuthTestArticle.new(params[:id])
  end

  def override_authority
    @article
  end

  def current_user
    Thread.current[:test_current_user]
  end
end

def dispatch(method, path, user: nil)
  Thread.current[:test_current_user] = user
  session = ActionDispatch::Integration::Session.new(AuthTestRoutes)
  session.public_send(method, path)
  session.response
end

RSpec.describe 'Article controller authorization' do
  after { Thread.current[:test_current_user] = nil }

  describe 'GET /articles/:id/edit' do
    context 'when user is nil' do
      it 'returns 404' do
        expect(dispatch(:get, '/articles/1/edit', user: nil).status).to eq(404)
      end
    end

    context 'when user is :admin' do
      it 'returns 200' do
        expect(dispatch(:get, '/articles/1/edit', user: :admin).status).to eq(200)
      end
    end

    context 'when user is not :admin' do
      it 'returns 404' do
        expect(dispatch(:get, '/articles/1/edit', user: :guest).status).to eq(404)
      end
    end
  end

  describe 'DELETE /articles/:id' do
    context 'when user is :peon' do
      it 'returns 404 (unless: peon rule)' do
        expect(dispatch(:delete, '/articles/1', user: :peon).status).to eq(404)
      end
    end

    context 'when user is not :peon' do
      it 'returns 200' do
        expect(dispatch(:delete, '/articles/1', user: :guest).status).to eq(200)
      end
    end
  end

  describe 'CannedGateKeeper' do
    it 'allows stubbing access granted in controller specs' do
      gk = FatModelAuth::CannedGateKeeper.allows(:edit)
      expect(gk.allows(nil).to_edit?).to be true
    end

    it 'allows stubbing access denied in controller specs' do
      gk = FatModelAuth::CannedGateKeeper.denies(:edit)
      expect(gk.allows(nil).to_edit?).to be false
    end
  end
end
