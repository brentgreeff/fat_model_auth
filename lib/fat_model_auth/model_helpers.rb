module FatModelAuth
  module ModelHelpers
    def allows(*params)
      if self.respond_to? :gate_keeper
        class_eval do
          self.gate_keeper.add_rules(params)
        end
      else
        class_eval do
          cattr_accessor :gate_keeper
          self.gate_keeper = FatModelAuth::GateKeeper.new(params)

          define_method "allows" do |user|
            self.gate_keeper.check(self, user)
          end
        end
      end
    end
  end
end
