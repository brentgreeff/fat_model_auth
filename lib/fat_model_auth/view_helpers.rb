# frozen_string_literal: true

module FatModelAuth
  module ViewHelpers
    def allowed_to?(options)
      actions, authority = options.first
      raise FatModelAuth::AuthException, "#{authority.inspect} is nil" if authority.nil?

      actions.to_s.split('_or_').any? do |action|
        authority.allows(current_user).send("to_#{action}?")
      end
    end
  end
end
