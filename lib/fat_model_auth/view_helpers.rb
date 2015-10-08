module FatModelAuth
  module ViewHelpers
    def allowed_to?(options)
      authority = options.values.first

      actions(options).any? do |action|
        authority.allows(current_user).send "to_#{action}?"
      end
    end

    private

    def actions(options)
      return options.keys.first.to_s.split('_or_')
    end
  end
end
