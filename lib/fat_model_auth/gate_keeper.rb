module FatModelAuth
  class GateKeeper

    def initialize(params)
      @map = {}
      add_rules(params)
    end

    def add_rules(params)
      h = params.pop
      auth_condition = h[:if]
      auth_condition ||= proc {|model, user| !h[:unless].call(model, user)}
      methods = params

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
  end
end
