# frozen_string_literal: true

module FatModelAuth
  class CannedGateKeeper
    def self.allows(action)
      new(action => true)
    end

    def self.denies(action)
      new(action => false)
    end

    def self.build(params)
      new(params)
    end

    def initialize(params)
      @map = {}
      add_rules(params)
    end

    def allows(_user)
      self
    end

    def method_missing(method, *_args)
      raise NoMethodError, "undefined method allows(user).#{method} for #{self.class}" unless @map.key?(method)

      @map[method].call
    end

    def respond_to_missing?(method, include_private = false)
      @map.key?(method) || super
    end

    private

    def add_rules(params)
      params.each do |action, response|
        @map[:"to_#{action}?"] = -> { response }
      end
    end
  end
end
