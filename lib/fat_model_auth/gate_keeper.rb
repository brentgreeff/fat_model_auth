module FatModelAuth
  class GateKeeper
    def initialize(params)
      @map = {}
      add_rules(params)
    end

    def add_rules(params)
      *methods, options = params
      auth_condition = options[:if] || negate(options[:unless])

      for method in methods
        @map["to_#{method}?".to_sym] = auth_condition
      end
    end

    def check(model, user)
      @model = model
      @user = user
      self
    end

    def method_missing(method, *args)
      unless @map.has_key? method
        raise NoMethodError, "undefined method allows(user).#{method} for #{@model.inspect}"
      end
      return false if @user.nil?

      @map[method].call(@model, @user)
    end

    private

    def negate(predicate)
      proc do |*args|
        !predicate.call(*args)
      end
    end
  end
end
