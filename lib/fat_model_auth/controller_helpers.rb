# frozen_string_literal: true

module FatModelAuth
  class AuthException < StandardError; end

  module ControllerHelpers
    protected

    def auth_required
      access_granted = authority.allows(current_user).send("to_#{params[:action]}?")
      respond_with_404_page unless access_granted
    end

    def access_denied?
      access_granted = authority.allows(current_user).send("to_#{params[:action]}?")

      if access_granted
        false
      else
        respond_with_404_page
        true
      end
    end

    private

    def authority
      if respond_to?(:override_authority, true)
        result = override_authority
        raise FatModelAuth::AuthException, 'override_authority defined but nil' if result.nil?

      else
        authority_name = controller_name.singularize
        result = instance_variable_get("@#{authority_name}")
        raise FatModelAuth::AuthException, "#{authority_name} is nil" if result.nil?

      end
      result
    end

    def respond_with_404_page
      if defined?(Rails) && Rails.respond_to?(:application) && Rails.application
        render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
      else
        head :not_found
      end
    end
  end
end
