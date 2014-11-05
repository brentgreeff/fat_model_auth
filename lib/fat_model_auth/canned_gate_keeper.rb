module FatModelAuth
  class CannedGateKeeper
    def self.allows(method)
      self.new(method => true)
    end

    def self.denies(method)
      self.new(method => false)
    end

    def self.build(params)
      self.new(params)
    end

    def allows(user)
      self
    end

    def initialize(params)
      @map = {}
      add_rules(params)
    end

    def add_rules(params)
      for param in params
        response = param.pop
        @map["to_#{param.pop}?".to_sym] = lambda { response }
      end
    end

    def method_missing(method, *args)
      unless @map.has_key? method
        raise NoMethodError, "undefined method allows(user).#{method} for #{self.class}"
      end
      @map[method].call
    end
  end
end
