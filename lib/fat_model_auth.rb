require 'fat_model_auth/controller_helpers'
require 'fat_model_auth/model_helpers'
require 'fat_model_auth/view_helpers'
require 'fat_model_auth/canned_gate_keeper'

ActionController::Base.send(:include, FatModelAuth::ControllerHelpers)
ActiveRecord::Base.send(:extend, FatModelAuth::ModelHelpers)
ActionView::Base.send(:include, FatModelAuth::ViewHelpers)
