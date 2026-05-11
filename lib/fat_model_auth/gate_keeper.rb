# frozen_string_literal: true

module FatModelAuth
  class GateKeeper
    def initialize(params)
      @map = {}
      add_rules(params)
    end

    def add_rules(params)
      *methods, options = params
      auth_condition = options[:if] || negate(options[:unless])

      methods.each do |method|
        @map[:"to_#{method}?"] = auth_condition
      end
    end

    def check(model, user)
      Checker.new(@map, model, user)
    end

    private

    def negate(predicate)
      proc { |*args| !predicate.call(*args) }
    end

    class Checker
      def initialize(map, model, user)
        @map = map
        @model = model
        @user = user
      end

      def method_missing(method, *_args)
        raise NoMethodError, "undefined method allows(user).#{method} for #{@model.inspect}" unless @map.key?(method)

        return false if @user.nil?

        @map[method].call(@model, @user)
      end

      def respond_to_missing?(method, include_private = false)
        @map.key?(method) || super
      end
    end
  end
end
