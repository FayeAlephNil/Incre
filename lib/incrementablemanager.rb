class IncrementableManager
  @@count = Hash.new
  @@vals = Hash.new
  @@incrementables = Array.new
  @@count.default = 0
  @@vals.default = 0
  def self.count
    @@count
  end
  def self.count=(args)
    @@count = args
  end
  def self.vals
    @@vals
  end
  def self.vals=(args)
    @@vals = args
  end
  def self.incrementables
    @@incrementables
  end
  def self.incrementables=(args)
    @@incrementables = args
  end
end
