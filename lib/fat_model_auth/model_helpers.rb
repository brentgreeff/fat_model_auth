# frozen_string_literal: true

module FatModelAuth
  module ModelHelpers
    def allows(*params)
      if respond_to?(:gate_keeper) && gate_keeper
        gate_keeper.add_rules(params)
      else
        class_attribute :gate_keeper
        self.gate_keeper = FatModelAuth::GateKeeper.new(params)

        define_method :allows do |user|
          self.class.gate_keeper.check(self, user)
        end
      end
    end
  end
end
