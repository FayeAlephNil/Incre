class IncrementableManager
  def initialize
    @incrementable_count = Hash.new
    @vals = Hash.new
    @incrementables = Array.new
    @incrementable_count.default = 0
    @vals.default = 0
  end
  attr_accessor :incrementable_count, :vals, :incrementables
end
