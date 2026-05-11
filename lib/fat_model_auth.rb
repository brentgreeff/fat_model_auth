# frozen_string_literal: true

require 'action_pack'
require 'active_support'

require 'fat_model_auth/version'

require 'fat_model_auth/railtie' if defined?(Rails)

module FatModelAuth
  extend ActiveSupport::Autoload

  autoload :ControllerHelpers, 'fat_model_auth/controller_helpers'
  autoload :ModelHelpers,      'fat_model_auth/model_helpers'
  autoload :ViewHelpers,       'fat_model_auth/view_helpers'
  autoload :GateKeeper,        'fat_model_auth/gate_keeper'
  autoload :CannedGateKeeper,  'fat_model_auth/canned_gate_keeper'
end
