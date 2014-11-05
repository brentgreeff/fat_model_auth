require 'action_pack'
require 'active_support'

require 'fat_model_auth/railtie' if defined?(Rails)

module FatModelAuth
  extend ActiveSupport::Autoload
  autoload :ControllerHelpers, 'fat_model_auth/controller_helpers.rb'
  autoload :ModelHelpers, 'fat_model_auth/model_helpers.rb'
  autoload :ViewHelpers, 'fat_model_auth/view_helpers.rb'
  autoload :GateKeeper, 'fat_model_auth/gate_keeper.rb'
  autoload :CannedGateKeeper, 'fat_model_auth/canned_gate_keeper.rb'
end
