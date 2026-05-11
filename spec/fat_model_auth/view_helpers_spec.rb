# frozen_string_literal: true

require 'spec_helper'
require 'fat_model_auth/view_helpers'

class TestViewContext
  include FatModelAuth::ViewHelpers

  attr_accessor :current_user
end

RSpec.describe FatModelAuth::ViewHelpers do
  let(:view) { TestViewContext.new }

  it 'raises AuthException when authority is nil' do
    expect { view.allowed_to?(edit: nil) }.to raise_error(FatModelAuth::AuthException)
  end
end
