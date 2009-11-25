module FatModelAuth
  module ViewHelpers
    def allowed_to?(options)
      authority = options.values.first
      
      get_actions(options).each do |action|
        return true if authority.allows(current_user).send "to_#{action}?"
      end
      return false
    end
    
    private
    
    def get_actions(options)
      return options.keys.first.to_s.split('_or_')
    end
  end
end
