module FatModelAuth
  module ViewHelpers
    def allowed_to?(options)
      actions, authority = options.first

      actions.to_s.split('_or_').any? do |action|
        authority.allows(current_user).send "to_#{action}?"
      end
    end
  end
end
