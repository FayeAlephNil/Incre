class BaseIncrementable
  @@name = nil
  @@linked_attr = nil
  @@amount_per_increment = nil
  def initialize
    $incrementables[$incrementables.length + 1] = self
    self.class.make
  end
  def self.make
    $incrementable_count[@@name] += 1
  end
  def tick
    to_add = @@amount_per_increment * $incrementable_count[@@name]
    $incrementable_vals[@@linked_attr] += to_add
  end
end
