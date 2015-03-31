require_relative 'lib/sampleincrementable'

$incrementable_count = Hash.new
$incrementable_count.default = 0
$incrementable_vals = Hash.new
$incrementable_vals.default = 0
$incrementables = Array.new

SampleIncrementable.new
IncrementableManager.vals[:sample_gain] = 5

loop do # Main loop
  IncrementableManager.incrementables.each do |incrementable| # Tick each incrementable
    if incrementable != nil
      incrementable.tick
    end
  end
  sleep 1
  p IncrementableManager.count
  p IncrementableManager.vals
end
