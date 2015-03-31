require_relative 'incrementablemanager'

class BaseIncrementable
  @@name = nil
  @@attr_to_increase = nil
  @@amount_per_increment = nil
  @@bind_attr = nil
  def initialize
    IncrementableManager.incrementables[IncrementableManager.incrementables.length + 1] = self
    self.class.make
  end
  def self.make
    IncrementableManager.count[@@name] += 1
  end
  def tick
    to_add = @@amount_per_increment * IncrementableManager.count[@@name]
    IncrementableManager.vals[@@attr_to_increase] += to_add
    if @@bind_attr != nil # binding to an attr is not needed
      IncrementableManager.count[@@name] = IncrementableManager.vals[@@bind_attr]
    end
  end
end
