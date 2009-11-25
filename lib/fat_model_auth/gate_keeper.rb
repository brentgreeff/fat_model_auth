module FatModelAuth
  class GateKeeper
    
    def initialize(params)
      @map = {}
      add_rules(params)
    end
    
    def add_rules(params)
      auth_condition = params.pop[:if]
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
        raise NoMethodError, "undefined method allows(user).#{method} for #{@model}"
      end
      return false if @user.nil?
      
      @map[method].call(@model, @user)
    end
  end
end
