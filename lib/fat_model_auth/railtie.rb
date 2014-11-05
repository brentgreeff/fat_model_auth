require 'rails/railtie'

module FatModelAuth
  $my_rails_root = Rails.root
  
	class Railtie < Rails::Railtie
		initializer "fat_model_auth.controller_helpers" do |app|
      ActiveSupport.on_load :action_controller do
        include FatModelAuth::ControllerHelpers
      end
    end
  end
end
