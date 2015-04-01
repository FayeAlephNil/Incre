require_relative 'incrementablemanager'

class BaseIncrementable
  @@name = nil
  @@attr_to_increase = nil
  @@amount_per_increment = nil
  @@bind_attr = nil
  def initialize
    CURRENT_GAME.incrementables << self
    self.class.make
  end
  def self.make
    CURRENT_GAME.incrementable_count[@@name] += 1
  end
  def tick
    to_add = @@amount_per_increment * CURRENT_GAME.incrementable_count[@@name]
    CURRENT_GAME.vals[@@attr_to_increase] += to_add
    if @@bind_attr != nil # binding to an attr is not needed
      CURRENT_GAME.incrementable_count[@@name] = CURRENT_GAME.vals[@@bind_attr]
    end
  end
end
