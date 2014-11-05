require 'rails/railtie'

module FatModelAuth
  class Railtie < Rails::Railtie
    initializer "fat_model_auth.controller_helpers" do |app|
      ActiveSupport.on_load :action_controller do
        include FatModelAuth::ControllerHelpers
      end

      ActiveSupport.on_load :active_record do
        extend FatModelAuth::ModelHelpers
      end

      ActiveSupport.on_load :action_view do
        extend FatModelAuth::ViewHelpers
      end
    end
  end
end
